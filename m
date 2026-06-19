Return-Path: <linux-can+bounces-7886-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S2wZFEkkNWoRngYAu9opvQ
	(envelope-from <linux-can+bounces-7886-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 13:13:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AB86A5619
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 13:13:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.net header.s=s31663417 header.b=U89dLQYL;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7886-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7886-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F6AF3004DB0
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992DA367B87;
	Fri, 19 Jun 2026 11:13:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82495326928;
	Fri, 19 Jun 2026 11:13:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781867586; cv=none; b=VK/YZCJLmOS00Cr4c+DSUQ75NSNuwwwhmhWeqEFctNCYverSyverxpZJWhE1Tsye2b8acn7KvLY+KDjWuLWNqpMWAtvlGUPYWz+q0cZcysdIUqXeVZ+q6xgwcWrXjrN9jRUtsj7vdR1H7+2Pu/DawCNKpQsV6glIsSxTVJ5bekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781867586; c=relaxed/simple;
	bh=hjtXpG2tNwGDnBcO7N3XLPwCnBggI6P5gm+obYSHO+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ID4k4ck2ymSj0ey2nmRTLRlvmdUuCQW8r/F+sfMDUD5qua6W/nYcw/gSnDpxdwRj5KY5GgFRT3d5ui1fNJxH5maOc5Ir5/BVZQP2bhgDDzh7HpVEAZDptEH7dvsW1uwj75hO+4nSGYTr5S18jYbESB6C1bCysJKm5TrdkDxY2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=U89dLQYL; arc=none smtp.client-ip=212.227.15.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1781867580; x=1782472380;
	i=alexander.hoelzl@gmx.net;
	bh=8x5Dv+Xk+TUOlQx20xPUAy9UKy1EtABS8ENINrKPTXs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U89dLQYLTN2GLI18gK3lIf+qFuq0hrzVPe8DwZp5f1H+oWd7LQEtrj37Q0ODB9s6
	 PthvcuA7SdIVvNx9F/Cv/xu3t55pTfZvgrB50nmwe7oz+iymb8AffG+q+/S8H1vCn
	 MKZUm+T77PmMij+PC+57a9SusrJliL6iLmlLNSdkajWFV6WrDOtxNmwPJbnNC2HX7
	 dk/WXi8aDemeSfQSuHtQ9fFWsBmHoKDwC1gLQHmfo6LywpylrTFTpLFdfyodIIpzG
	 LZWwFLoTsSLHMjDdR4NZgge1O5NXPQ135q4aotxFaeCGu1sF0o/dh/kuiHL/+tYuA
	 5tnlPlX9bDUw/YJFSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1wb5O22EvC-0043K9; Fri, 19
 Jun 2026 13:13:00 +0200
Message-ID: <384691b4-0642-483c-a8eb-ff07c721288a@gmx.net>
Date: Fri, 19 Jun 2026 13:13:00 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Fix J1939 implementation not handling holds
 correctly
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 linux-can@vger.kernel.org
References: <20260525190948.42461-1-alexander.hoelzl@gmx.net>
 <aikxhGFiBbvdg3l2@pengutronix.de>
From: =?UTF-8?Q?H=C3=B6lzl=2C_Alexander?= <alexander.hoelzl@gmx.net>
Content-Language: , en-US
In-Reply-To: <aikxhGFiBbvdg3l2@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hlj+WLGdnLbJByCQXVCrDv4aa8FJ0WjEbAuaqnZ1WVQ7UW6ET2n
 SSx4tQbQNDqzBguRdSV8Rnigi+d95yJhkhzDPukXIA4ZFGjump3RVINuEDeyP94bjWQq9bP
 Cyh4nPMa96HzVZ/SB+CX3wgHoXPivPvtwpgjAwiAgb2UPtjE8PWoNaWdY7cElkkBawLDSg+
 6iDJW3uV9TW4xvt4Qb1NA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jqZRr2yrTIg=;oqkRzE6IRhqOvQhlVIPvVKxlJbG
 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
 VQlGzHJde6N6P3+RzbTaYQOgMchbd2CBb2CbxE7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:robin@protonic.nl,m:linux-kernel@vger.kernel.org,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7886-lists,linux-can=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.net];
	FORGED_SENDER(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35AB86A5619

Hi Oleksij,

Am 10.06.2026 um 11:42 schrieb Oleksij Rempel:
> Hi Alexander,
>=20
> Sorry I lost the track of this patches.

No worries!

> Can you please take a look here:
> https://sashiko.dev/#/patchset/20260525190948.42461-1-alexander.hoelzl%4=
0gmx.net
>=20
> You can ignore the warning in net/can/j1939/transport.c
> I guess it is protocol specific issue (potentially can be commented in
> the source code), if you have other opinion, please share :)
>=20

The bot is right and after looking through the specs once again
there are requirements mentioned regarding retransmission
requests. In 5.10.3.2 Connection Mode Clear to Send (CTS):
...
When the CTS message is used to request the retransmission of data=20
packet(s), it is recommended not to use more than two retransmit=20
requests. When this limit is reached, a connection abort with abort=20
reason 5 from Table 6 shall be sent.
...

This paragraph to me sounds more like a requirement for the responder to
stop requesting retransmissions.


Second there is also this:
5.12.3 Device Response Time and Timeout Defaults
...
Number of request retries =3D 2 (3 requests total); this includes the=20
situation where the CTS is used to request the retransmission of data=20
packet(s). If the retransmit request limit is reached, then the=20
connection abort shall be sent with abort reason 5 from Table 6.
...
This sounds a bit more generic and not related specifically to responder=
=20
or originator. I did not see a mention of in any of those requirements
in the compliance spec J1939-82 however...

Do you think I should add a counter for retransmit requests?
If yes should it also apply to holds?

> There are some typos in the tests, can you please address them.
>=20
Sure!> On Mon, May 25, 2026 at 09:08:48PM +0200, Alexander H=C3=B6lzl wrot=
e:
>> The J1939 protocol allows the receiver of directed segemented messages
>> to hold the data transfer. The kernel implementation did not handle hol=
d
>> messages correctly was not able to resume from a hold.
>>
>> To do so the behavior of j1939_xtp_rx_cts_one was modified to allow the
>> handling of a hold. The previous sanity check was removed as it only
>> guarded against a flood of consecutive CTS, but prevented the hold
>> from working correctly. This patch changes this behavior to allow
>> for consectuive CTS to enable holds. An additional sanity check
>> has been added which prevents requsts of already transferred and
>> acked packets. In this case the kernel will abort immediately
>> instead of going into a timeout.
>>
>> Fix J1939 RTS/CTS session not being able to resume from hold.
>> Replace hardcoded timeout with define.
>> Add CTS hold behavior tests.

...
In addition just want to mention this check I've introduced, which=20
prevents requesting packets which the responder has already acknowledged=
=20
in a previous CTS:>> -	/* set packet counters only when not CTS(0) */
>> +	if (session->pkt.tx_acked >=3D pkt) {
>> +		err =3D J1939_XTP_ABORT_DUP_SEQ;
>> +		goto out_session_cancel;
>> +	}
>> +
I couldn't find this requirement in J1939-21 but the compliance testing=20
spec J1939-82 mentions it in table A7 row 6:

	Verify DUT transmits a TP.Conn_Abort when 'Next packet number
	to be sent' in TP.CM_CTS message:
	- is less than the 'Next packet number to be sent' in =09
	  previous TP.CM_CTS

Should I add this as a comment as well?

Regards,
Alex

