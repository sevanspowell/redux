import React from 'react'
import PropTypes from 'prop-types'
import {
    format,
    logPrice
} from '../purs/Product'
import {
    main
} from '../purs/Format'
import {
    Nothing,
    Just
} from '../purs/Data.Maybe'

class PureScript extends React.Component {
    initialize(props) {
        return (node) => {
            if (node != null) {
                props.main(node)(props.state)((query) => {
                    this.query = query;
                })(_ => null);
            }
        };
    }

    componentWillReceiveProps({price, quantity, title}) {
        if (this.query) {
            const state = {price, quantity: quantity || 0, title};
            this.query(state)(_ => null)(_ => null);
        }
    }

    shouldComponentUpdate(nextProps, nextState) {
        return false;
    }

    render() {
        return (
            <div ref={this.initialize(this.props)}></div>
        );
    }
}

PureScript.propTypes = {
    main: PropTypes.function,
}

const Product = ({ price, quantity, title }) => {
    const state = {price, quantity: quantity || 0, title};
    return (<PureScript main={main} state={state} />)
};

Product.propTypes = {
    price: PropTypes.number,
    inventory: PropTypes.number,
    title: PropTypes.string,
}

export default Product
