Return-Path: <linux-can+bounces-2693-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603B3A1B7D9
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2025 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB24D7A4109
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2025 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B72186339;
	Fri, 24 Jan 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HrWUnNKJ"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-74.smtpout.orange.fr [193.252.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D378F4E
	for <linux-can@vger.kernel.org>; Fri, 24 Jan 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728720; cv=none; b=cIah5pm2q0pVwq2FsnWTtW/7ppoG5R70gRLrgHpUWgXETD4PkuMmn5AoVs4cr85FUNs6XTlOHfHKFKtTFWedUCeAbbGXVMwTQ8oTov78MvfdHExVe97xRWMVxGkP3GNQU6FmF9PNU8CBTV+gxRifAeve8GURKbnuaXPz+SjVoK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728720; c=relaxed/simple;
	bh=/DOd1qa532sDzGYmalRnkunlu5lXmGYE11cZfOcIHGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8PWnisX1wGNKMONKhkRtcuwK3jBoPIuTYiv7gYmbRbgxMOJHm2xIccWviowtd4Dqb+WwgyaHu3fiHq7smzNC34QCExmmaPudj1Hi43wYuhXzJnA+0m46QD1NW5iteMXummVnprxcu9Ar0SFMfnyt4JvJRpcpU6MGlA/Jky3BSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=HrWUnNKJ; arc=none smtp.client-ip=193.252.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by smtp.orange.fr with ESMTPSA
	id bKTvtnxgop1eZbKTytSCZX; Fri, 24 Jan 2025 15:16:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1737728186;
	bh=0I1UPIruv9gG7FGWEP5nixeEhP97IOrQH/HQ7++kFkQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=HrWUnNKJtKSRVaGLCDHJ6ncaH4EgwlGLBvBfmD2qRWvj8fn8f/RwLxuCHs7BXK+WU
	 3g/WvAkk9kIH/VN71EkX1yCmhhHrtMd6kEa7RynhnPBQxoDBelIGuk2pj4kzuOXdup
	 R+6WHg7RMwdzEj1hj9fkj7lTxxzvVvtFKTwdH7Ygva/CBlkBJWXgdKvVu+PrjntDTZ
	 b+LhZlblzSRVdhde7cK8FqSUOGw/RHliq1yexErG8G5vtXztwEA4WzI5Fq15A6Kfd8
	 +43cBPyUC2A2vTR93p0w+PZSbcqxzqW9cmBpDwBHpRsaFNJIaIOpMZYLmYQ7k8BXhZ
	 pqQ4WMCpfF3VQ==
X-ME-Helo: mail-ej1-f49.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 24 Jan 2025 15:16:26 +0100
X-ME-IP: 209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa68b513abcso456033666b.0
        for <linux-can@vger.kernel.org>; Fri, 24 Jan 2025 06:16:26 -0800 (PST)
X-Gm-Message-State: AOJu0YwmIqKzXYPJgOEUdgCx54E92Z+9o/wkpTs7ACboz1i4+iafGhmb
	IH/Zr+78hWg/899CT1/WMRRlcJ2MaFB3ZKZPH4nRWLlom1uWZTzqz4dwu5G9jIaKqL/5ulewKbL
	k7E8duK1AUfOCA5m5+SzgSUdyJIA=
X-Google-Smtp-Source: AGHT+IH2hXKcoJ9KI8SXsVLEQSrFAINsQgk3f93xqeHtbnsn9w1SMZpWniq+4rFDXKBq2Jx00oA03WJmzWmtVq50Qrk=
X-Received: by 2002:a17:907:1b03:b0:aaf:ab71:67b6 with SMTP id
 a640c23a62f3a-ab38b167b80mr3021098066b.31.1737728183027; Fri, 24 Jan 2025
 06:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM8PR05MB8052EFD0609D2F65BECBE1AE8FE32@AM8PR05MB8052.eurprd05.prod.outlook.com>
In-Reply-To: <AM8PR05MB8052EFD0609D2F65BECBE1AE8FE32@AM8PR05MB8052.eurprd05.prod.outlook.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 24 Jan 2025 23:16:11 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKgFG=zhQTDWdrGHH1Sey1mLNFWQFAjTCcrXUgPdKTYrQ@mail.gmail.com>
X-Gm-Features: AWEUYZlh4tOv_tPJiQMIer9Fs01_HqC5FBSY5Hro7kYqtUr2Rg2GelJ-w55I9Ng
Message-ID: <CAMZ6RqKgFG=zhQTDWdrGHH1Sey1mLNFWQFAjTCcrXUgPdKTYrQ@mail.gmail.com>
Subject: Re: [Issue] Bosch D_CAN echo skb occupied error
To: "Schmidt, Stefan" <schmidtssstefan@siemens-healthineers.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Thank you for your great write-up on your finding.

On Fri. 24 Janv. 2025 =C3=A0 18:29, Schmidt, Stefan
<schmidtssstefan@siemens-healthineers.com> a =C3=A9crit :
> Dear linux-can Members,
>
> I hope this message finds you well. My name is Stefan Schmidt, and I am r=
eaching out to seek your guidance regarding the "echo socket buffer occupie=
d error".

Welcome on the mailing list!

> Context:
> Recently, we updated our kernel from 4.14 to 6.1.43 and our Debian from 1=
0 to 12.
> The system runs on an Altera Cyclone V, which has two Bosch D_CAN CAN Con=
trollers on board. We use both. Additionally, it is a dual core system with=
 two Arm cores.
>
> Issue:
> After the update, I saw that both CAN devices sporadically print the mess=
age "BUG! echo_skb %d is occupied!" once into the syslog, with %d always be=
ing index 0.
> From there on the affected device was unable to send any messages. A rest=
art of the device (ifdown/up) recovered the problem.
>
> Steps Taken:
> After heavily polluting the driver with trace points, I found out that in=
 this case, the echo socket buffer is indeed still occupied by an old messa=
ge on index 0.
> Looking at the preceding usage of index 0, I saw that both functions c_ca=
n_start_xmit and c_can_do_tx  (drivers/net/can/c_can/c_can_main.c ) were ex=
ecuted on different cores at the same time.
> One was called by the tx-interrupt of the CAN controller and was schedule=
d on CPU0.
> The other one was called by the application / network layer and was sched=
uled on CPU1.
> As both functions operate on the same resources (variables in RAM and CAN=
 controller registers), I think that there should be some kind of synchroni=
zation mechanism, but I did not find any in the code.
>
> Theory:
> I think that the caching mechanism, that was introduced somewhen after th=
e 4.14 version of the kernel, can get compromised by this parallel executio=
n.
> In the beginning of c_can_start_xmit, the function checks if there is a w=
rap around in the buffer. If this is the case, the message just gets prepar=
ed, everything gets written to the chip, but the final transmission request=
 is not set.
> ```c
> // (1) drivers/net/can/c_can/c_can_main.c - c_can_start_xmit
> cmd &=3D ~IF_COMM_TXRQST; /* Cache the message */
> ```
> In the end of c_can_start_xmit this command gets written to the CAN contr=
oller.
> ```c
> // (2) drivers/net/can/c_can/c_can_main.c - c_can_start_xmit
> c_can_object_put(dev, IF_TX, obj, cmd);
> ```
> The final trigger to send the message shall then be set in the tx-interru=
pt, as soon as message from object index 15 (last index) was processed, bec=
ause otherwise, the new message on index 0 would bypass the one on index 15=
 and change the order in which they are put on the bus.
> ```c
> // (3) drivers/net/can/c_can/c_can_main.c - c_can_do_tx
> c_can_object_put(dev, IF_NAPI, obj, IF_COMM_TXRQST);
> ```
> My theory is, that as it is possible that both functions run parallel on =
different CPUs, I think that it is possible that this can happen that it ha=
ppens in this order (1) -> (3) -> (2). Which leads to the situation that th=
e transmission request bit is immediately reset after being set.
> To support my theory, I put a spinlock around both critical code sections=
. As of now, this seems to properly solve the issue, but I am aware that th=
is is probably the clumsiest way to do it.
>
> Request:
> I am reaching out to you because I have not found anyone else with a simi=
lar problem on the internet.
> It would be great if you could share your thought about this problem and =
maybe give some hints for a cleaner solution.
>
> Additional Details:
> Please find my clumsy fix with the spinlock below. I don't think that it =
is ready to be merged to any official repository, but maybe it is a short-t=
erm help for someone who is in a similar situation.

So, theoretically, it should be possible to have a lockless queue
under the conditions that:

  - there is only one reader at a time
  - there is only one writer at a time
  - the queue size is a power of 2

This design will then abuse the C unsigned integer wraparound
property. The c_can/d_can meets all above requirements, so normally,
no locks are needed here.

So I think that the core issue is somewhere else. Looking at the
recent commits, [1] and [2] caught my attention:

[1] commit 387da6bc7a82 ("can: c_can: cache frames to operate as a true FIF=
O")
https://git.kernel.org/torvalds/c/387da6bc7a82

[2] commit 81d192c2ce74 ("can: c_can: don't cache TX messages for C_CAN cor=
es")
https://git.kernel.org/torvalds/c/81d192c2ce74

Those two are present in 6.1.x on which you are having your problem.

What triggers me the most is the fact that the D_CAN, on which you are
having your problems, have a special if condition:

  https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/c_can/c_can=
.h#L244

In addition, [2] says that, I quote:

  the optimization introduced in [1] doesn't properly work on
  C_CAN, but on D_CAN IP cores. The exact reasons are still
  unknown.

The other part of the queue implementation looks good to me. Only this
c_can_get_tx_free() caught my attention.

Can you try to revert above commits [1] and [2] and tell us if you
still have the issue?

> Thank you in advance for your time and assistance. I look forward to hear=
ing your suggestions or advice.

Thank you for the detailed report. Let me ask you: do you want to
write the final patch? If yes, we can guide you into the process.


Yours sincerely,
Vincent Mailhol

