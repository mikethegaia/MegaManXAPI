class Boss {

    constructor(id, name, hp)
    {
        this.id = id;
        this.name = name;
        this.hp = hp;
    }

    get id()
    {
        return this._id;
    }

    set id(id)
    {
        this._id = id;
    }

    get name()
    {
        return this._name;
    }

    set name(name)
    {
        this._name = name;
    }

    get hp()
    {
        return this._hp;
    }

    set hp(hp)
    {
        this._hp = hp;
    }

}

module.exports = Boss;