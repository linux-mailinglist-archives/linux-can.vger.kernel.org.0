Return-Path: <linux-can+bounces-7394-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD6AFPHn6Wm2nAIAu9opvQ
	(envelope-from <linux-can+bounces-7394-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 23 Apr 2026 11:35:45 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9130444FBE2
	for <lists+linux-can@lfdr.de>; Thu, 23 Apr 2026 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B0C300FC7B
	for <lists+linux-can@lfdr.de>; Thu, 23 Apr 2026 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9632652B0;
	Thu, 23 Apr 2026 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="P7PE7OQw"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5733E2743;
	Thu, 23 Apr 2026 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936942; cv=none; b=LPV8GrgvB5blVHkyBZ4nkHUjjqrVVPmfg2ekr91yuQos0PNuZuJVrtUf6IG414olNTfZQWkG4tpqViVyj2OYQM1j/hNdlEZOppzjBUr0CnFClvCWRXtY8Jm0XubRQHrPWma3drlOOoqESWkI4Ig3sz7qc94fVvX3Uwcdfscmeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936942; c=relaxed/simple;
	bh=KXb0Y9vkDpODk/TcwbFWqZ/OPMZ1LMHY6j6WqRpCMpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=IQykk3fpkSds39IWgilVGS0moAf+gaHjADGlJDD8LJDqKoMeUknxJbZapAdcEG1jLabJbp4de6iOEESVhKbFCH8O+Y6Ukq0f4Uz23wZQcPoZzFY5f9nq7qWLBMOV0X881A/TCrzlgIilJXMk3ebQp0+WDjyCF4zNwvQbg7JtJ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=P7PE7OQw; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1776936928; x=1777541728;
	i=alexander.hoelzl@gmx.net;
	bh=A4MK5tEcIxzLLfW8kU8GD6xFYsL1SYDqlbTOq+t4CWc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P7PE7OQwgB0qhMECo1fHBwiRErRdqJ0m/e6gaE5X9wABa1MKqwhlFavEpXgOp85r
	 1g648q3HQZBvW7Un5gGkQEuyEXuMVxmLaUxf7iDnKhowjKIhns7yrdsB6akwZZX+A
	 36rplU8agXPkUU9QPy1/3HFEbSVKHc4tvH8KNGR796Fq2T2mk5PJ3ywhbSvHXgg3h
	 Yo/b9uzO5O7VbNX5FZJBQIKjLY0U2VG/Adp99qQCxgT7rhw3/vPAQNmZDgx2SaBqu
	 xb903w7S0/bWtCcnDUvPEKyX3+xDzNupIsQETLR1WfhehZuCdvcTwr7qhrZ5AF/nl
	 ZmUyi0sRX72hSKBK9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1wBhSt1RFj-005rkr; Thu, 23
 Apr 2026 11:35:28 +0200
Message-ID: <3e17efb4-ae71-4b5c-af23-7b5de9c5e03c@gmx.net>
Date: Thu, 23 Apr 2026 11:35:27 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: j1939: fix wrong rx timeout for CTS hold messages
To: Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
 <aemW6JThLpOu5BNg@pengutronix.de>
From: =?UTF-8?Q?H=C3=B6lzl=2C_Alexander?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 linux-can@vger.kernel.org
In-Reply-To: <aemW6JThLpOu5BNg@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lrlk4uOIOkV44zBfznyFZufV9To2omSd7JZHSNGKDj3nGfWIRVr
 2lFDQsUKFUdQ7ppbcWIFKec2cDl/o5/1XGXyOP4O4PS5+Fp8G+iSuOzs8DJmJTbKEZhxLuE
 eMuketxx5Ar2fZ9Gu1rfusJeXvJUBOyrlI2sRWgeu6RbQIxf+4uCfJCUmF7sKn3g2TPJmk6
 nyVJ3LJbt6pHcyszNw7hQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lpFkv3DD1kg=;rxd/jt3r+cHxAZregDJsnfR9Flo
 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
 P9NjLBYt6Y469WQ==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7394-lists,linux-can=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.net];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9130444FBE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hello Oleksij,
thank you for your quick review!

Am 23.04.2026 um 05:50 schrieb Oleksij Rempel:
> Hi Alexander,
>=20
> On Tue, Apr 21, 2026 at 05:31:54PM +0200, Alexander H=C3=B6lzl wrote:
>> In J1939 segmented transport, a CTS message with data byte 2 set to zer=
o is interpreted as a hold message.
>> This instructs the transmitter of the segmented message to hold the con=
nection open but to delay sending.
>> According to the J1939-21 standard, section 5.10.2.4 the timeout T4 aft=
er which an held open session is invalidated is
>> 1050 ms, not 550 as implemented currently.
>> The 550 ms are problematic if a device uses hold messages and assumes i=
t can wait for more than 550 ms before it has
>> to resend the hold message.
>>
>> This patch changes the T4 timeout used in the implementation from 550 m=
s to 1050.
>>
>> Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
>=20
> LGTM. Thank you!
>=20
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
>=20
>=20
> Sashico detected one more potential issue, not related to this patch:
> https://sashiko.dev/#/patchset/20260421153152.87772-3-alexander.hoelzl%4=
0gmx.net
>=20
> If you have time, can you please verify it?
I just tried it and to be honest it seems that holds are fundamentally=20
broken currently. I don't think there is any way to restart normal=20
communication as soon as a hold has been received.

When I send a hold with byte 3 set to FF and try to resume from sequence=
=20
number 1 I get an abort with reason 08 which is "Duplicate sequence=20
number" according to the spec:
(000.000000)  can0  18EC31F9   [8]  10 0A 00 02 02 00 AB 00
(000.001166)  can0  18ECF931   [8]  11 00 FF FF FF 00 AB 00
(000.101138)  can0  18ECF931   [8]  11 02 01 FF FF 00 AB 00
(000.000685)  can0  18EC31F9   [8]  FF 08 FF FF FF 00 AB 00

The same happens when setting byte 3 to 01:
(000.000000)  can0  18EC31F9   [8]  10 0A 00 02 02 00 AB 00
(000.001077)  can0  18ECF931   [8]  11 00 01 FF FF 00 AB 00
(000.100910)  can0  18ECF931   [8]  11 02 01 FF FF 00 AB 00
(000.000657)  can0  18EC31F9   [8]  FF 08 FF FF FF 00 AB 00

Setting it to 0 is disallowed as well and the transmission is cancelled=20
immediatley with error 05 which is "Maximum retransmit request limit=20
reached.":
(000.000000)  can0  18EC31F9   [8]  10 0A 00 02 02 00 AB 00
(000.000941)  can0  18ECF931   [8]  11 00 00 FF FF 00 AB 00
(000.000645)  can0  18EC31F9   [8]  FF 05 FF FF FF 00 AB 00

There is a check at the beggining of j1939_xtp_rx_cts_one for duplicate=20
sequence numbers which targets byte 0, so the command type byte, and=20
checks that it is not equal to the last command.

if (session->last_cmd =3D=3D dat[0]) {
		err =3D J1939_XTP_ABORT_DUP_SEQ;
		goto out_session_cancel;
	}

This means it is impossible to handle two directly succeeding CTS which=20
would be necessary to escape the hold....

The easiest way to fix this would probably be to move the check for a=20
hold message all the way to the top of j1939_xtp_rx_cts_one and if a=20
hold message has been received just set the rx-timeout timer and then bail=
?

>=20
> Best Regards,
> Oleksij

Kind regards,
Alexander


