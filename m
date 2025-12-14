Return-Path: <linux-can+bounces-5865-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BDCBBFB1
	for <lists+linux-can@lfdr.de>; Sun, 14 Dec 2025 20:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CD2A3007EEF
	for <lists+linux-can@lfdr.de>; Sun, 14 Dec 2025 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280917A309;
	Sun, 14 Dec 2025 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="w1cq3jPT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="LgpazSlO"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E62BCF5
	for <linux-can@vger.kernel.org>; Sun, 14 Dec 2025 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765742031; cv=pass; b=OcyDt7hAqqGUDJ9dWFTvqZR0UcP6/XF/DC/UCapalQQGkMV979oPSNmNoU8IZlTjJJJhV2dbYTB5dg25DYHCMd4s0YRs0mE2Llm1PR8mb1cD/sIsGwKWHR25OlBp89xaVnKgqkTFDxHOu4/MgeQcQgEplbnLuiA1WzysE+sWN0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765742031; c=relaxed/simple;
	bh=9U/4H0u7IeO8SK9G+ka43cBTeRHALsUFMjkDklSXq3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1Jy7xp2M5Ye/9skZLUBas1ynQ2Me6Ak2Qqf/VyoacK+coJy/To1ecuJFqHqusJv1yCRtiK8pCvwcDl91GznM/UUbXpk3EIyM+WyV0t5qD9mvlDUDEGJ+OUE2U/WMPlC62wsGz8ef/plNAR/WsihtFhVrPJH5T1XZQKL7hLg1cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=w1cq3jPT; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=LgpazSlO; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-swd7.prod.antispam.mailspamprotection.com; s=arckey; t=1765742029;
	 b=OGikhN3usNJSl0OibyZPBvklusuyFbcr+rr05+VK2r2KUWhdV9hcpkxetJG8H0iNZ35qG7cj/6
	  iM1VWEV23DY83Y7xCsKtFwzyt0saprTfktbDOu4gj1sfYJWMs6eGLvtijeyaz5V/xe7aLdk5Hk
	  Nq7HmVQPqmAIhPCbzB4NyYmEnKx4z+q/Myfcg9xvPhxe488CFBBFxj/03vUEknpf1SfzM7OAZX
	  kQ4gllJF611bqIQ18Ip5CjBCSM+KWl42Sn7vUH67S+LJ6qUzh/vv8hAS3q+XOZU4V+duGMH3L2
	  2TPX5ypXCUwpvOH5Q2SYvaILRewRAupRqv6cxSrF+RX6rQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-swd7.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-swd7.prod.antispam.mailspamprotection.com; s=arckey; t=1765742029;
	bh=9U/4H0u7IeO8SK9G+ka43cBTeRHALsUFMjkDklSXq3I=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=T59YVB5jcYtbsn1vzyRnkt8U9EA5JwS94sqCkENs1CnGJJDKPsdWmuR7t68UHUqwd7OIpVWTbi
	  gVxNt1CnUsr5Cv871FCsslQKHSH0naInCISkNMjmZPHnTMz3DS/0ZkpBVkvGVVZvJZc0D4hggD
	  vmewpmvaa0nkt8JxLU9pOTcSd5PBZF0u6rElwhgbL2SKy1lLhR3x+LXpByncCgiHPNBewkkAiY
	  eaZkF94uS19VfIgC55Gls4Qcre9raKe6QRjMTYb/4A7gpd4vswzsSZJCoSLLvBTut39Rhns44A
	  PxBN8etjzSiJz6pbcHs2FgRv64RPUHh4JMzj46fvUe+1oA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=o+wKOrFZelyH+jQJOnvI/aGEta4ZGrzG5vU+orLBrOc=; b=w1cq3jPTBSkrxgljvMZD+jzkS7
	w+rpxP+9BjF/hIcK4RPgIRsm912wfBkzRGIPtj3K/Pm+yopQjz3r8bfCR5xgUy+WhCNQjzm9BrvHg
	ejcFCrRZGCqTDa6jL5ucNGp1CwKuS/Wt/X2YRkbykJ4UTC3KKIxMhWfdVCz2uqlO9xAY=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-h9hs.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vUn1j-00000000vPO-0v8e
	for linux-can@vger.kernel.org;
	Sun, 14 Dec 2025 14:24:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=o+wKOrFZelyH+jQJOnvI/aGEta4ZGrzG5vU+orLBrOc=; b=LgpazSlOYH6J/Z6Ak0/vT65R7X
	nENUiSrlgAPkiFlGYqYoZtoIoZaJcxK3E5ElOO4pwurJMRKXZO32ufNpJ9eJML8hP4K0nrzGXs8sx
	ETxYXpuoDz27BjAm8gG8YpOzLKQ8Y7Mv/892OAxuN2tMx6evxwI3Mi645dcDz58gepFE=;
Received: from [79.34.194.176] (port=60598 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vUn1U-000000006Go-1D9P;
	Sun, 14 Dec 2025 14:24:32 +0000
Date: Sun, 14 Dec 2025 15:24:30 +0100
From: Francesco Valla <francesco@valla.it>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aT7InsN51RIyIeA2@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTw2LORF0QiEcgM1@fedora>
 <20251214022000-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214022000-mutt-send-email-mst@kernel.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: a238fd903fdb5e9513d082e9e3af9394
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vUn1j-00000000vPO-0v8e-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-swd7.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Sun, Dec 14, 2025 at 02:20:36AM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 12, 2025 at 04:35:08PM +0100, Matias Ezequiel Vara Larsen wrote:
> > > > +
> > > > +	priv->can_ctr_msg.cpkt_out.msg_type = cpu_to_le16(msg_type);
> > > > +	sg_init_one(&sg_out, &priv->can_ctr_msg.cpkt_out,
> > > > +		    sizeof(priv->can_ctr_msg.cpkt_out));
> > > > +	sg_init_one(&sg_in, &priv->can_ctr_msg.cpkt_in, sizeof(priv->can_ctr_msg.cpkt_in));
> > > > +
> > > > +	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, priv, GFP_ATOMIC);
> > > > +	if (err != 0) {
> > > > +		/* Not expected to happen */
> > > > +		dev_err(dev, "%s(): virtqueue_add_sgs() failed\n", __func__);
> > > > +		mutex_unlock(&priv->ctrl_lock);
> > > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > > +	}
> > > > +
> > > > +	if (!virtqueue_kick(vq)) {
> > > > +		/* Not expected to happen */
> > > > +		dev_err(dev, "%s(): Kick failed\n", __func__);
> > > > +		mutex_unlock(&priv->ctrl_lock);
> > > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > > +	}
> > > > +
> > > > +	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
> > > > +		wait_for_completion(&priv->ctrl_done);
> > > > +
> > > 
> > > Since the call is synchronous, does can_ctr_msg really need to be part
> > > of priv? Cannot be it allocated from the stack?
> > > 
> > 
> > I tried to allocate in the stack but the guest blocks when during `ip
> > link set up can0`, any idea?
> 
> you can not DMA to/from the stack, really.
>

Right. Forgot aboud DMA, my bad.

> -- 
> MST
> 
> 

Regards,
Francesco

