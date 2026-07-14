Return-Path: <linux-can+bounces-8371-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IDcdDlgEVmopyAAAu9opvQ
	(envelope-from <linux-can+bounces-8371-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:41:44 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89044752FA8
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 11:41:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RQ9z0SVj;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8371-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8371-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B145317DE03
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 09:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A71143E4BE;
	Tue, 14 Jul 2026 09:30:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4352843FD29
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 09:30:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021445; cv=pass; b=YwXLp0hpUHgQnInPRJFzWK+/KkU4uhdrcyTGSmLnynIjSXqIn1Hkwy+5CGg0v6e2NeB6S1Jw/EVRpraaT/qxsjNfFw6lHsTREHtksV+eTTWL1NgBygxCMFPuT9+h1CpCP9ij0DAsj+B9/nM/myW6YmOhgwQRLY3L4r05bC0cFR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021445; c=relaxed/simple;
	bh=I6G3Q+FXZ5EmFID/Q3+wjhwXv5YFhtj8kbKtXbaP7aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6j6LehYiVxSm6JJ8f1vBhIZKkj5TzWLUOkcANGHAL/T/PcBegy3WcRAq7Rh38h3Oq21/gIYf4xMFQABZOpX4SPs9tv3U+R76rLUL0xy3XiGZiLqCPunGnotA0G37GR0YFiSv8WvdHvzK6Hk43gtAmhgRR0+3tzCGRSXWC83uvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQ9z0SVj; arc=pass smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ccf2360620so5674585ad.3
        for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 02:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784021434; cv=none;
        d=google.com; s=arc-20260327;
        b=YGBNiu64oUodB9FQlDTrXqItOjucBNwbio05FxUINhdWBPLSMfpkyrpf33Um8Fhyrv
         0PIWXcfuijm/Q/DXORua0dO5f9mqy4Q3odNSiDt9ssyNXtL0Y2+Qdz3SwsI5Lq20c/by
         1F7dE/ZrQrqvKnZmPVK+iJ0Ub5hnY2Hts7YY+Q6t4pR3jXVySkcAHVgu87dTXaeqsCmV
         0BlHq5lOp2yglD2gLzrPCyb166Uu6jAl2DGdaXX9Vv9m8tAGonhakk/IJxKhEZMXZpHy
         7TTny0uuQq4A5fymgt74Znpd1TKrDe2YOjDjWMG4r5tSlLCw+I/aP71HgaEh1XXgzrxa
         J1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v+QJ/aXOEJkF1qKOqd78f73WO0NWahWbfl7RnnArRcg=;
        fh=jS/YI/Tewnon624mR5EIfNxFcW1cTt2WGRTuRCSiNJw=;
        b=DmvcrX12iz8f07ZRPeOK813/nwPsjr5AczqzEKOI2BsQjf6lUpD2Fepg/4B3pOoVM/
         rjCA3UVow430J2FJ3oA6ckMlBFOpZ2UsBY+rdoFA6rtxJwFkUTvmNLQ/iTs6dHjUOPPF
         /9/FkSEvCQj4NFouPyaw+TAkJUfdHIVM0Kh7iBXOR52opjHritcHa//PVop0ckt1QR5T
         GSvE9scTX0tXKv8T2r3BsO23PHx25X+JxI2H8W/WewZr1HG5850sfdKjnZRih1pXG+A+
         uztEbAGkkqoehJkrvT6u3pkGw54gDHH4TUaNvamFCWKw48xtLSDzufbpnHtlucAZbwkz
         UGNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784021434; x=1784626234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v+QJ/aXOEJkF1qKOqd78f73WO0NWahWbfl7RnnArRcg=;
        b=RQ9z0SVjugQWrjanJyVeYWyyRbW7XZuMgu6dWwjoUT6Wcu2/ZLrcNobRLKz0xYWp4e
         qpC9mYeIDoWpDh4f3rgPKRHs9dQoKggdu/3Dv80UiOxOU6BRdacWRD5jCFJ9lI2Y+8d3
         +ZHcqwDBXctxjfo9O2F8U0DHR/5KDG/vEzXINfpzl0CiLUmtJWKPsRlaOVvcMBMfLfbS
         KOoIpnnDq8tIr1ZT1HyvSiQ6o2XvpirvpjLvBdArNAPxyZkDF+0HvKTbgPO3j832bHa5
         0Diw/Kh3uylwcNH5UtZFKBE5dQC6g90VeACD7JDEwC/vzdIG0Nxt5/Kt4j6YMF8INStU
         VNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021434; x=1784626234;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+QJ/aXOEJkF1qKOqd78f73WO0NWahWbfl7RnnArRcg=;
        b=OT22VTPt7uKc+9wBwTggS89S53xw92P4oqi6Vwge5vERzuEVlBoYkkFmAgfUkUiDHj
         xTfP6vMamzSJDfxN8xfUCq/5wq67DClY5M8B5m0Jcz5dZXwfw3ozvxgFzh6EiDAj3MFw
         1bpmc0nphaOjIuJLF3oZ1DQoXkFz6c/nwrPBfegsc6VdZ9x9ZFWlX5eiKxGTOVSVJzxH
         mGfHMFWnoTgSHahZCbhChInrQfG548FQ+AvVgTRwJFm0PCgg1cuP/m86fOqXg2KLvzJH
         wmxIO8yqxnlMWNfFuO7ceVU3eBYhSOhfAClmJAH0ddP0ARuTxWNJe1VBmTWvVoZkBC4i
         RWCQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdwKQwMnrUUz396VtqDAsL7focZ6xgv2/0/RGc6V4yT9A5AaCpYiR+PgZmPBCUBrrRPJgxVNndjzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1gCelrYUCcwOSXccFmIRNw9uBiFZnymyN9hLzllN+zq7GFHp
	3DEJZQJSn5WxQdZF3pVPllSNYhyapEpbuy1FOgQO2wyOQyh5tfiiuFe3QGBE/mSJtgEDQfMa2lb
	qSP2fuDolzlQNnt7OnJ7yvf7VS7MQTysj2GyukHct
X-Gm-Gg: AfdE7ckY6/XwZ0I+Aj+OX4AVTxCp0n8uL+3B/cbObqNbPqRV9s/dyafGW02O2ufmJMy
	HQL8Hhkc4L+D2dW+6EZyU+PhMfeR8geajpRzF01IBuM5VWe3diTky8AC0NBDk6PhbelFYmWr/lf
	FHoko9UFpQXVArZcYkH5vXpkNm556/REAEIoEsRtcpMXYvEAoVP4wLiaebDiMiyQ6hMv2OniKbs
	XpMVHiniygxpWzgdB99VcgBa+YFzhDykCIst5MNJ7R+8UxGjTSKEDnFfL0Fp9pWIsedEbNSM3OM
	Q9xsFmoBlPdK5S0ctI+KqVhg81CJweYBeyrKtTHje3b4PYRescB6l9qS4HNE5oP/UyWyTfoqz7B
	R6dGERqd3GEE=
X-Received: by 2002:a05:6a21:496:b0:3a2:d79c:416c with SMTP id
 adf61e73a8af0-3c110a0ec3dmr14089180637.32.1784021433321; Tue, 14 Jul 2026
 02:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712212113.181121-1-kuniyu@google.com> <20260712213422.DB1111F000E9@smtp.kernel.org>
 <a2afe72f-5098-4a6f-9df7-b993f186337a@hartkopp.net>
In-Reply-To: <a2afe72f-5098-4a6f-9df7-b993f186337a@hartkopp.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Jul 2026 11:30:21 +0200
X-Gm-Features: AVVi8Cdpr6dJWdakTie8bvgkbftvPiYnlf1nFXm4YqURw-4ZDxBH3T29_IrQQKQ
Message-ID: <CAAVpQUBy2Ws8iuvv4WBBcCHQkkQLL5E2Nu=_dnvxR=ehN6gXkg@mail.gmail.com>
Subject: Re: [PATCH v1] vxcan: Support per-netns device unregistration.
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:sashiko-reviews@lists.linux.dev,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8371-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,hartkopp.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89044752FA8

On Mon, Jul 13, 2026 at 9:57=E2=80=AFAM Oliver Hartkopp <socketcan@hartkopp=
.net> wrote:
> On 12.07.26 23:34, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Low] The patch calls the undefined function `unregister_netdevice_qu=
eue_net()`, resulting in a compilation error.
> > --
> >
> > --- Patch [1]: [PATCH v1] vxcan: Support per-netns device unregistratio=
n. ---
> > commit 882fcd31630d9ce6b0a57cc99738c2ad0579763f
> > Author: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > vxcan: Support per-netns device unregistration.
> >
> > This commit updates vxcan_dellink() to unregister local and peer device=
s
> > safely across different namespaces by using xchg(). The change aims to
> > prevent double-queuing of device destruction when RTNL is removed.
> >
> >> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> >> --- a/drivers/net/can/vxcan.c
> >> +++ b/drivers/net/can/vxcan.c
> >
> > [ ... ]
> >
> >> @@ -281,24 +284,25 @@ static int vxcan_newlink(struct net_device *dev,
> >>
> >>   static void vxcan_dellink(struct net_device *dev, struct list_head *=
head)
> >>   {
> >
> > [ ... ]
> >
> >>      unregister_netdevice_queue(dev, head);
> >>
> >> -    if (peer) {
> >> -            priv =3D netdev_priv(peer);
> >> -            RCU_INIT_POINTER(priv->peer, NULL);
> >> -            unregister_netdevice_queue(peer, head);
> >> -    }
> >> +    priv =3D netdev_priv(peer);
> >> +    dev =3D unrcu_pointer(xchg(&priv->peer, NULL));
> >> +    if (dev)
> >> +            unregister_netdevice_queue_net(dev_net(dev), peer, head);
> >
> > [Severity: Low]
> > Is this missing a prerequisite patch? It appears that
> > unregister_netdevice_queue_net() is not defined anywhere in the kernel
> > tree, which leads to a compilation error when building vxcan.c.
>
> The referenced veth.c patch was applied to net-next:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3Dd7fda2c776b2a969b9d78c5ad00e30824df43add
>
> where also unregister_netdevice_queue_net() exists.
>
> So this is a net-next resp. can-next patch.

Yes, I meant this is for can-next, but I was not sure how frequently
the tree is synced against net-next and what's the best approach here.

