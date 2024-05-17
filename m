Return-Path: <linux-can+bounces-648-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723398C8960
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2024 17:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B00282D19
	for <lists+linux-can@lfdr.de>; Fri, 17 May 2024 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E325612D212;
	Fri, 17 May 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KFyjp5QG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dPnNRHpx"
X-Original-To: linux-can@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49712CD8A;
	Fri, 17 May 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959939; cv=none; b=EaAq9GZl0XTa60fyIHcCZINBOct9K5ToWs2JkLr/p4cJahldVvtWUZLWDJQA9ss3M8WL2rZ3kmFOAqXmC2Hs7LkhTFBn/GyZhTiZgpRsv6DrXBRz27IqbgMBQtGEkDF3kBjgOVTZP28nFL79vl9oGgwNvuyFgaMd2AG82PbCUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959939; c=relaxed/simple;
	bh=D+aZeg+2cJFRvQasfMNMmYWH8MS31v4X+wRV4Zfj6AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayqcw4r9ET+VR8GqSGlYdhjQ9FYvwtIzUHssBAGcTObCNhIT7HB6N6h7YwLCEmSMKhpzWY8SBAtrjW5UdYO1qiD+ILTIFrFjuqxJNziPvuCKQITke1tFmYHZUBwDavpLgYqD5gbJPmSbPsuy+2g85H9bqMK/xB7n/hhmJf0Izq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=KFyjp5QG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dPnNRHpx; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.nyi.internal (Postfix) with ESMTP id 88422200450;
	Fri, 17 May 2024 11:32:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 17 May 2024 11:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1715959936;
	 x=1715967136; bh=s8Q/l0wRHpTp9lBxT46kDXxjSSe7yKH9ZdbIurG921s=; b=
	KFyjp5QGLxIPQPo4O+zmoE47Jgqxd4Yz/Ph7adPQ819doQ+vUOamctaLYbQaDSkE
	STG2S4bzMOEA5CslT/UDD9Y7pKT7GBNySNmiVaWJ+NHcJGY4BLU7p91iAUr6OZIo
	hYwJG1kNRrWyVv4nGK2DMdEtXjkxj/xCbgIZjWFbvNiaPyvJPmSkucmAwwLci3i5
	wYPhrb+5fvfBtiikiIR4T2F8/z61p3dXUcWrK4tIJ8/DO+rYS5jS30EF8FtN+Do1
	eqB3VXCW9KlhlSPy6qv/3ctxn+mUO9W8e4o8IkRyWQP/2VE4YY6sNlsYI0j0pZoy
	W9A7lKeKTdjUVN5ozuH2iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715959936; x=
	1715967136; bh=s8Q/l0wRHpTp9lBxT46kDXxjSSe7yKH9ZdbIurG921s=; b=d
	PnNRHpxgGOd3y0t1HZgRFwZq0lIa84YUvy7ksSoEKQ6dsraCoxAFp2Ojqdb+pLFP
	WhNjPExz/Q7yUwZbdDfSvyoncx9yvhy2Wqt/kXDeIiaH+aLkwIh/8cbn9PCr3hNa
	/lwPttFQO4j1LM6KbomvWoG3QisosZl/i0E5f0Bv0TQ5leEknPqjs/PuQHvP+l9s
	+nsSrHmxGUVvX/lH7YZ4phwURyx2OK169Y73Z3VLs0ShNEyZz7SWV5XL3kXqMOBV
	tYtoSs5lG3pPMPutNuBadU7VjC1/W2bVlHqNCs3hhkh7h9tPJS+WWY/2m2Eb0BdJ
	R+KeeQH8r6lLCZqCD946A==
X-ME-Sender: <xms:gHhHZi_uoK0ohc3Ob6gTqQ_1YFBMK9BwMXiP7vU3A8F6xXC4Vp6Iew>
    <xme:gHhHZivAzSBO33oW1odv7C7dFOi_mmb95QGi4mMHbGXQ7ioLokx3_RRAcUtw1Vxhe
    HXJwpdIqsg2wQ>
X-ME-Received: <xmr:gHhHZoDMRTtQu9GIwlN8P0cmn1ErQNGXIR45mXKdiZDQPwOMep0gSYBydS8WYBxhcNcB513fL3Qz-Y7QQFyRafHAghAnC3AQCC4Seg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnheple
    ekheejjeeiheejvdetheejveekudegueeigfefudefgfffhfefteeuieekudefnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:gHhHZqd-Vr2ozLK8ZN89CLKz5_JvooYw2FTifP2xp1PJekIN-Xigpw>
    <xmx:gHhHZnO71SM8Pki1pXjseWsw1UcmznmbIHbUnd3u9Cfdu1YfaIKasg>
    <xmx:gHhHZkm-VFHPtBCePeAys828Z6op_Tp3MI5GgDViB_eHzcYML_dTig>
    <xmx:gHhHZpss9O8sYpESFJo2an3fRrSxZ1DqU5DX7EZLxnrivDafY6QCbQ>
    <xmx:gHhHZo_D6DA87FMkIMNExhtlzq06u_JdSDIXNrql534y6tV7vURO7teR>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 11:32:15 -0400 (EDT)
Date: Fri, 17 May 2024 17:32:12 +0200
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Vitor Soares <vitor.soares@toradex.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	Vitor Soares <ivitro@gmail.com>
Subject: Re: [PATCH v6] can: mcp251xfd: fix infinite loop when xmit fails
Message-ID: <2024051744-evaluate-dubbed-8433@gregkh>
References: <20240517134355.770777-1-ivitro@gmail.com>
 <b95de04f-a2f8-4564-b9d4-9c09c47f23c3@web.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b95de04f-a2f8-4564-b9d4-9c09c47f23c3@web.de>

On Fri, May 17, 2024 at 04:44:18PM +0200, Markus Elfring wrote:
> …
> > This patch resolves the issue by starting …
> 
> Will further imperative wordings be more desirable for an improved change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.9#n94
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

