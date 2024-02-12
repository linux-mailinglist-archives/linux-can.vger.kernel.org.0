Return-Path: <linux-can+bounces-230-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA5E851DFE
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 20:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DF8281A72
	for <lists+linux-can@lfdr.de>; Mon, 12 Feb 2024 19:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301947772;
	Mon, 12 Feb 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b="x7jY7XrO"
X-Original-To: linux-can@vger.kernel.org
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574846B8B
	for <linux-can@vger.kernel.org>; Mon, 12 Feb 2024 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766708; cv=none; b=La2Zy1aY2mh/aUVNqQPHPbvdXYqg17Pj0mndwDxtbKfNHYXHoExu+N9kegWsTFz11tYuZ7sRYF7SMc7qsDONICk7lPbHnfIiDb58BL5qJT3ljV901w/onOhpWOzosooPSN7l+sfyjeO8QhD3w3VgXPkKVxYoc8eT63gEapxwoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766708; c=relaxed/simple;
	bh=KThCClrcog2rHYFbXsWGHxwjVcCZcEgylPveewoWGzY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=vFreMP919TvEXu8pl2x2wtW0Z4cyP/9TxRR48lirR+AzBGo3emMEK3bSOW3q/qvDHCOcESI11o6iXuL5gd5Huz6w7Akv7W0lQs9SOdBOgwlQ0by9tXL6dzcQaEdqbJpc+5YnrB7qk2UJugaIw03e/A/X8SHqCC24pJ9Xws0V4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net; spf=pass smtp.mailfrom=sonic.net; dkim=pass (2048-bit key) header.d=sonic.net header.i=@sonic.net header.b=x7jY7XrO; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sonic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sonic.net
Received: from smtpclient.apple (173-228-4-48.dsl.dynamic.fusionbroadband.com [173.228.4.48])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 41CJRWpo017980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Feb 2024 11:27:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonic.net; s=net23;
	t=1707766054; bh=7bfu2IjSpMs1JymwPAtlW8b1v+yFISMymH/dkIftlE0=;
	h=Mime-Version:Subject:From:Date:Message-Id:To:From:Subject;
	b=x7jY7XrOhi68valCWGoKBFoyvOZ0LZmVLvhiO7U0e+wRY9IhWR/m1aMbO54VpWkkW
	 1fmqmWVQC1gXZCC3ZiKg3cM7K0jhU8SLJ2EWq0Js3T4nROSf5Z6LgWoHor4k5Zl5Qh
	 eKRnrwYSDyxPWuoObHHG1dhQPsMwrV6bnyNsbSumEamoFVUgMhJ/ujgjqz6Z/F9Y20
	 7G33UyWLKu0pGWDqXx0S6pqf/rvTQYbZ+XmreQmgVl0rxpg2H1NfVfhifPgN43DkaQ
	 TiJUL0LETOIzAMdi09SVR36XClj7ZyNY4NphB3MEAyWBwNKkP1qGJZb4Z8mLdDqmhx
	 wcjnRrgVV0XKQ==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH rework v1] canxl: add virtual CAN network identifier
 support
From: Guy Harris <gharris@sonic.net>
In-Reply-To: <4a3f3605-6a54-4ca0-9581-eff900e6b169@hartkopp.net>
Date: Mon, 12 Feb 2024 11:27:21 -0800
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <vincent.mailhol@gmail.com>, linux-can@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <94162CA9-1EDC-4DD9-854D-48125819D2E2@sonic.net>
References: <20240212151404.60828-1-socketcan@hartkopp.net>
 <4a3f3605-6a54-4ca0-9581-eff900e6b169@hartkopp.net>
To: Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: Apple Mail (2.3731.700.6)
X-Sonic-CAuth: UmFuZG9tSVZTj8XL4xEqkLbMnzi8XTV5EWIqi44PWqiE7lEzb4OoRjhXJwoyrpKbIyHR2JGqfd2r9r+oitMroQGQ4+3L9Q0l
X-Sonic-ID: C;YCtpxNzJ7hGzzyFnR+6Zsg== M;GkiXxNzJ7hGzzyFnR+6Zsg==
X-Spam-Flag: No
X-Sonic-Spam-Details: -0.0/5.0 by cerberusd

On Feb 12, 2024, at 7:26 AM, Oliver Hartkopp <socketcan@hartkopp.net> =
wrote:

> I'm currently in discussion with Guy Harris who's working on the =
Linux-CAN support in Wireshark.

*AND* in libpcap.  Note that anything done with the metadata headers of =
SocketCAN packets affects both of them - and any programs *other* than =
Wireshark that capture on SocketCAN adapters or read pcap or pcapng =
files with SocketCAN packets.

> We current have two approaches how to integrate the VCID into the =
struct canxl_frame:
>=20
> 1. Add the VCID at a specific 16 bit offset (above the 11 bit Prio ID)
> 2. Create a endian-dependent data structure with a separate uint8 VCID
>=20
> 1: =
https://lore.kernel.org/linux-can/20240212151404.60828-1-socketcan@hartkop=
p.net/
> 2: =
https://lore.kernel.org/linux-can/20240128183758.68401-1-socketcan@hartkop=
p.net/
>=20
> The endian-dependent data structure looks like this:
>=20
> struct canxl_frame {
> #if defined(__LITTLE_ENDIAN)
>        __u16 prio;   /* 11 bit priority for arbitration */
>        __u8  vcid;   /* virtual CAN network identifier */
>        __u8  __res0; /* reserved / padding must be set to zero */
> #elif defined(__BIG_ENDIAN)
>        __u8  __res0; /* reserved / padding must be set to zero */
>        __u8  vcid;   /* virtual CAN network identifier */
>        __u16 prio;   /* 11 bit priority for arbitration */
> #else
> #error "Unknown endianness"
> #endif
>        __u8  flags;  /* additional flags for CAN XL */
>        __u8  sdt;    /* SDU (service data unit) type */
>        __u16 len;    /* frame payload length in byte */
>        __u32 af;     /* acceptance field */
>        __u8  data[CANXL_MAX_DLEN];
> };
>=20
> @Guy: Besides the fact that suggestion 2 does not win a design prize =
I'm not sure whether solution 1 or 2 are better to maintain over =
lifetime.

The first question to ask is "which solution breaks less existing source =
and binary code"?

Currently, the SocketCAN metadata header for CAN XL frames begins with a =
4-byte integral-valued field.  I'm not seeing code in the tip of the =
main branch, in either the =
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
repository or the =
git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git =
repository, that sets or gets the prio field of the canxl_frame =
structure, so I'm guessing that the prio field in a canal_frame =
structure would be in *host* byte order when received or sent.

Presumably any software that sees that structure would either

	1) treat the prio field as containing the priority in the =
low-order 11 bits and zeroes in the upper 21 bits

or

	2) tread the prio field as containing the priority in the =
low-order 11 bits and would extract the priority by ANDing the prio =
field with CANXL_PRIO_MASK.

At the binary level, code that does 1) would be broken by putting the =
VCID in that field; the only way not to break it would be to add an =
additional field for the VCID, but *that* would change the length of the =
metadata header, which would break, at the binary level, any code that =
thinks the header is 12 bytes long, so there's nothing you can to to add =
the VCID without breaking that software, so that code shouldn't be taken =
into account.

At the *source* level, code that does 1) would be broken by putting the =
VCID in the 8 bits above the lower 16 bits, and wouldn't be broken by =
changing the structure to have the priority in a 16-bit field, with =
additional 8-bit vcid and reserved fields.

Code that does 2) would not be broken by *either* solution, at the =
source or binary level.

Having that as a 32-bit field named "priority" gives the field a name =
that doesn't indicate that it also includes the VCID.  Renaming of the =
field as "priority_vcid" would break source compatibility; adding

	#define priority	priority_vcid

would fix that, at the expense of possibly breaking or, at least, =
uglifying debugging of code that has a variable or function or structure =
name or... named "priority".

Having that as a 16-bit field named "priority", an 8-bit field named =
"vcid", and an 8-bit reserved field involves, for structure layout =
compatibility, two different sets of structure members, with byte-order =
tests at compile time, which is a bit ugly, but does make it clear that =
one field contains the priority (and 5 reserved bits) and another field =
contains the VCID.

*Both* solutions result in the metadata header's first 4 bytes being:

byte 0: lower 8 bits of the priority;
byte 1: 5 reserved bits and upper 3 bits of the priority;
byte 2: VCID
byte 3: 8 reserved bits

on little-endian machines and

byte 0: 8 reserved bits
byte 1: VCID
byte 3: 5 reserved bits and upper 3 bits of the priority;
byte 4: lower 8 bits of the priority

on big-endian machines, i.e. the layout of the data in memory is the =
same for *both* structures.=

