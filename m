Return-Path: <linux-can+bounces-7396-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAnRB8Ag6mntuQIAu9opvQ
	(envelope-from <linux-can+bounces-7396-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 23 Apr 2026 15:38:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EAF45314B
	for <lists+linux-can@lfdr.de>; Thu, 23 Apr 2026 15:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D40E3014A09
	for <lists+linux-can@lfdr.de>; Thu, 23 Apr 2026 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DADA27FD74;
	Thu, 23 Apr 2026 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="r7iVG0dF"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624827FB18;
	Thu, 23 Apr 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951269; cv=none; b=EM1kxQ/9AuT2X+WsiIt9SHtkzedDMCGT88K0EuqGdtw3uP2a/bF0zfTkRYm7lxrwxug7l6ic/dWkM+fCn7I5Vv5jXtQBryw/+naIx0v1g9gMiut8krdPr9S1j3lpAhryP69XGfAs6UWC0okMQVuFnhbeWp908EUI/ox5qajLLnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951269; c=relaxed/simple;
	bh=NHwFqWIEx04qq9fbF1d7vP9H5P/iUq98tr6bLdm7dAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5YNyGLUK6vt0teaVoQeWfPC15dzTZWOtB/O63yAAjc3HJoMI5dXHXsfQXuyTy9BlpeR6fkPVSWygVFB0lye+1LpAAW3vXGVwUenW0BCE4nrrO9n2pFqxjSz+1c011gZYXDHzmx1YQJuU9dkC7jGup3S/wPDKln5KMPE7JskQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=r7iVG0dF; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1776951258; x=1777556058;
	i=alexander.hoelzl@gmx.net;
	bh=H5E6gVP15fPt8vxKYKRoV+NGnvr6PL98176XG6/79NU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r7iVG0dFWehmqBDy6bUyeRsAG/ncPUfWHmzy4mkOp5IE+GMY444quNVUlC0EX3T3
	 wJ6y+SgVrq5IJGPATjAD6xr3IDTU2DML3sNoPjcrmgYJbBjlTT7mSPLViPv/+P3cR
	 JHj4jbuyPnTIYWVimX6juT1FmaE9U4N1Nx/OiqUR9pVnRaA7sO/6AAs59PKj/g8fI
	 VQHzEcHFQp+XXOFzBGG6xZYTj7ZOXWK3XNViRYUeqLpk6Pfu2TYvvkwqxURtnCSsH
	 zAhoY+4VB0ZuRnmhHPYD9/2uE/VngCieNTw9jN35zbU63VhRAUndWMgAaphHe+xND
	 U8yy5iWFXTvjChkbcA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNJg-1vtRMm1t6g-00Nv26; Thu, 23
 Apr 2026 15:34:18 +0200
Message-ID: <6afff3fa-8e81-44c0-aac6-bd71688ebfa9@gmx.net>
Date: Thu, 23 Apr 2026 15:34:18 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: j1939: fix wrong rx timeout for CTS hold messages
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 linux-can@vger.kernel.org
References: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
 <aemW6JThLpOu5BNg@pengutronix.de>
 <3e17efb4-ae71-4b5c-af23-7b5de9c5e03c@gmx.net>
 <aeoZn2BIOzZyCWo_@pengutronix.de>
From: =?UTF-8?Q?H=C3=B6lzl=2C_Alexander?= <alexander.hoelzl@gmx.net>
In-Reply-To: <aeoZn2BIOzZyCWo_@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Ci3PNFZSiWtWxFjf/0Coky1XAn123bvG/m90+FdpvJrUT6WnNt
 3H68j718LqGxTNex9c6qLeT+87woTDSnFq8TRqH/Zm4dcuO/3XvTiVybwf+Rsma8+2+NyMD
 eCUiOcmDnu4qEQUP+PB7/19iqcEEeQe3GumbjDAmX1pHyMIYNgMDW6oRlKMuWRp3C5+1LLb
 aMMJY9Cauk0iaaYpAVKvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y+oEGhr+5J0=;KU34aNmg+P9xwJEZyHnwatngYf8
 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
 RDiApw==
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7396-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmx.net];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmx.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	MAILSPIKE_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0EAF45314B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Am 23.04.2026 um 15:07 schrieb Oleksij Rempel:
> On Thu, Apr 23, 2026 at 11:35:27AM +0200, H=C3=B6lzl, Alexander wrote:
>>
>> Hello Oleksij,
>> thank you for your quick review!
>>
>> Am 23.04.2026 um 05:50 schrieb Oleksij Rempel:
>>> Hi Alexander,
>>>
>>> On Tue, Apr 21, 2026 at 05:31:54PM +0200, Alexander H=C3=B6lzl wrote:
>>>> In J1939 segmented transport, a CTS message with data byte 2 set to z=
ero is interpreted as a hold message.
>>>> This instructs the transmitter of the segmented message to hold the c=
onnection open but to delay sending.
>>>> According to the J1939-21 standard, section 5.10.2.4 the timeout T4 a=
fter which an held open session is invalidated is
>>>> 1050 ms, not 550 as implemented currently.
>>>> The 550 ms are problematic if a device uses hold messages and assumes=
 it can wait for more than 550 ms before it has
>>>> to resend the hold message.
>>>>
>>>> This patch changes the T4 timeout used in the implementation from 550=
 ms to 1050.
>>>>
>>>> Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
>>>
>>> LGTM. Thank you!
>>>
>>> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>>
>>>
>>> Sashico detected one more potential issue, not related to this patch:
>>> https://sashiko.dev/#/patchset/20260421153152.87772-3-alexander.hoelzl=
%40gmx.net
>>>
>>> If you have time, can you please verify it?
>> I just tried it and to be honest it seems that holds are fundamentally
>> broken currently. I don't think there is any way to restart normal
>> communication as soon as a hold has been received.
>>
>> When I send a hold with byte 3 set to FF and try to resume from sequenc=
e
>> number 1 I get an abort with reason 08 which is "Duplicate sequence num=
ber"
>> according to the spec:
>> (000.000000)  can0  18EC31F9   [8]  10 0A 00 02 02 00 AB 00
>> (000.001166)  can0  18ECF931   [8]  11 00 FF FF FF 00 AB 00
>> (000.101138)  can0  18ECF931   [8]  11 02 01 FF FF 00 AB 00
>> (000.000685)  can0  18EC31F9   [8]  FF 08 FF FF FF 00 AB 00
>>
>> The same happens when setting byte 3 to 01:
>> (000.000000)  can0  18EC31F9   [8]  10 0A 00 02 02 00 AB 00
>> (000.001077)  can0  18ECF931   [8]  11 00 01 FF FF 00 AB 00
>> (000.100910)  can0  18ECF931   [8]  11 02 01 FF FF 00 AB 00
>> (000.000657)  can0  18EC31F9   [8]  FF 08 FF FF FF 00 AB 00
>>
>> Setting it to 0 is disallowed as well and the transmission is cancelled
>> immediatley with error 05 which is "Maximum retransmit request limit
>> reached.":
>> (000.000000)  can0  18EC31F9   [8]  10 0A 00 02 02 00 AB 00
>> (000.000941)  can0  18ECF931   [8]  11 00 00 FF FF 00 AB 00
>> (000.000645)  can0  18EC31F9   [8]  FF 05 FF FF FF 00 AB 00
>>
>> There is a check at the beggining of j1939_xtp_rx_cts_one for duplicate
>> sequence numbers which targets byte 0, so the command type byte, and ch=
ecks
>> that it is not equal to the last command.
>>
>> if (session->last_cmd =3D=3D dat[0]) {
>> 		err =3D J1939_XTP_ABORT_DUP_SEQ;
>> 		goto out_session_cancel;
>> 	}
>>
>> This means it is impossible to handle two directly succeeding CTS which
>> would be necessary to escape the hold....
>>
>> The easiest way to fix this would probably be to move the check for a h=
old
>> message all the way to the top of j1939_xtp_rx_cts_one and if a hold me=
ssage
>> has been received just set the rx-timeout timer and then bail?
>=20
>  From a quick lock, it sounds plausible. Will you send a patch?
>=20
> Hm... we needs tests, preferably in kernel source to avoid regressions.
>=20
> would it be possible to implement is on top of kunit tests?
> https://lore.kernel.org/all/20260420152228.581421-1-o.rempel@pengutronix=
.de/
>=20
> It looks like there is more user space friendly testing used:
> https://lore.kernel.org/all/20260419144600.GA4091724@chcpu16/
>=20
>=20
Sure I'll write a patch and tests!


