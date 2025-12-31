enum RelationshipWithHomeowner {
  spouse,
  sibling,
  parent,
  child,
  relative,
  friend,
  other,
}

extension RelationshipWithHomeownerX on RelationshipWithHomeowner {
  String get label {
    switch (this) {
      case RelationshipWithHomeowner.spouse:
        return 'Spouse';
      case RelationshipWithHomeowner.sibling:
        return 'Sibling';
      case RelationshipWithHomeowner.parent:
        return 'Parent';
      case RelationshipWithHomeowner.child:
        return 'Child';
      case RelationshipWithHomeowner.relative:
        return 'Relative';
      case RelationshipWithHomeowner.friend:
        return 'Friend';
      case RelationshipWithHomeowner.other:
        return 'Other';
    }
  }
}
