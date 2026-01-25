Return-Path: <linux-can+bounces-6296-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ejvIxpUdmnGPQEAu9opvQ
	(envelope-from <linux-can+bounces-6296-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 18:34:18 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2463281991
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 18:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5463F3000FC7
	for <lists+linux-can@lfdr.de>; Sun, 25 Jan 2026 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297172853E0;
	Sun, 25 Jan 2026 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="bcBFn0e6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="ugF+Pjp8"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9623EBF01
	for <linux-can@vger.kernel.org>; Sun, 25 Jan 2026 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769362455; cv=pass; b=NZvBDM5KrDRIcGoEfM1vL3fOwCRPjEcxBFKoe8jzj7w4a7J6W0xjCTBHTmLd1qptiKDLzZBJbwpYS6R/sGwjLI0UChBtsN+bvUgh818mI/WEP3A7BoeQJl9EnVjIgNfeFeT78XMgQL0P64ItAoR8S1V4xRVi2oXbvjb1d5HqwdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769362455; c=relaxed/simple;
	bh=hJSx9oaMJHd1dMzail/Y0B2lv7BReDNTK69nls5nKFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L72yzJrCt/LugUFoK2iagy/CepLxHVIOyC0ykmvhHsfws1/TULY62u/R4Hmh1NIk+jW9qF+wm/ZsJNOS3kr9MapjJfXMaagxp4EAJilmatyV4USTRuBsg23+oCgCE6t+BYbiYVEsUw8neg1hEttiCyhPQeqlar0C96Rh7uNc7/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=bcBFn0e6; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=ugF+Pjp8; arc=pass smtp.client-ip=185.56.87.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-71v3.prod.antispam.mailspamprotection.com; s=arckey; t=1769362453;
	 b=RmeVmGxdYo5VVN9CfFvxWSxd1C0F/t/o7orKgdSGrxYx+TxcnkaDXyX4JQ/X2IPLrF5LkOJfvA
	  1KkvlkiUyVBq9fL6Y6Nw8JELG5SwlSPLu0gFj7FMTeDcZfPr8pCz/c/3GDRIS6Fb3QAIAEnIfY
	  H0Ba0Q+7merMV0c29G8qsB5vQ6DpUjBd9colmNKCfE1zI453eADWsLNGcAWHf3CyYcU+/DTNav
	  6rpBH/mZC2c+GFP8ekkBdn8GjMJTOHfdlfgqy2SlckIlS74yHfq4Xt00b5OrQFRtfSFPaRoAul
	  iTs9vf3OoZYAJKjy2dG5cBIIeTGz2iaTYrU6AQmAr467qQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-71v3.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-71v3.prod.antispam.mailspamprotection.com; s=arckey; t=1769362453;
	bh=hJSx9oaMJHd1dMzail/Y0B2lv7BReDNTK69nls5nKFU=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=dRpfBRpqorAR89ACWjSnOtdLq5Pc42xOWaqYwHFVXMiji7GMoZD8dxU2NWs7xjkWDA+hoFbTM3
	  yHucmT3h8EVW08JWvCLqIXmw51nx963ThbOODXW4sklp7XSbPMEXXYmW4eNzRRfLzWGA2keyHC
	  O31idfFjD6mrvpoKU/XmSEOTdCVZ8TDpZ2E6AgSlQaGkJ1snK2xH+IGz99e4GwF9I1B09ePp/C
	  BWWR8QVcZilsg0F1uZVmEL/crzx0Bv/moRiqtNlbtKBqUJn2XkQUbp95l1HaoQdqV0SC7bUCzO
	  +gX0w1VulKZwsnaiYA080nvSsZy+iR7SaESARyQCAWFBKg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=r+TZJIa35LWBpRleXzoyjL90NYJPxXwwqgV0e3QqGBc=; b=bcBFn0e67juzDuGN7aQRm3W1vx
	TVebLt+DDn9TqSsT5GwlQ0dNVP9pU7xIqHL7nIbv0wtv4QnsQ+LJVPfXWMHJZZFTak/1h9Yw5j761
	rKsotMhM4R68BuIkTpQHXUCMxMvw0Ap+YgXLlPumv5P3fLlpnVsBtxlrmIHMt+TYs2o8=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-71v3.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vk0pE-00000009MIq-0rlz
	for linux-can@vger.kernel.org;
	Sun, 25 Jan 2026 14:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=r+TZJIa35LWBpRleXzoyjL90NYJPxXwwqgV0e3QqGBc=; b=ugF+Pjp8zj0GIK0KOC3TzydUoW
	xGfbWKr4eiMlzS7Uu8JOvOtdjzSWE6qQ0/ShuMJR6CiqViqRMYfYxnwXK+2XxujOunl20vOkikqpx
	uO0wLEBGQ6Lqsv53eCCSYy27L4aJOiOsYbjtiGRNvettjRgOcbKkVizHaPVa9ne4/MWI=;
Received: from [79.52.39.254] (port=64962 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <francesco@valla.it>)
	id 1vk0p0-0000000023h-0aP4;
	Sun, 25 Jan 2026 14:10:34 +0000
Date: Sun, 25 Jan 2026 15:10:32 +0100
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v8] can: virtio: Add virtio CAN driver
Message-ID: <aXYkWO0ShTsrjP1R@bywater>
References: <aW/D8kiFu666wiuD@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW/D8kiFu666wiuD@fedora>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 0a897a82fef1c4bf7c12ab320facd42b
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vk0pE-00000009MIq-0rlz-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-71v3.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_REJECT(1.00)[antispam.mailspamprotection.com:s=default,valla.it:s=default];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[valla.it : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6296-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_X_SOURCE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[antispam.mailspamprotection.com:-,valla.it:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@valla.it,linux-can@vger.kernel.org];
	HAS_X_ANTIABUSE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2463281991
X-Rspamd-Action: no action

Hi Matias,

If an additional version is foreseen, consider dropping some more
note-like comments, as in future they might become dangling.

E.g.:

On Tue, Jan 20, 2026 at 07:05:38PM +0100, Matias Ezequiel Vara Larsen wrote:

[...]

> +
> +/* Poll TX used queue for sent CAN messages
> + * See https://wiki.linuxfoundation.org/networking/napi function
> + * int (*poll)(struct napi_struct *napi, int budget);
> + */
> +static int virtio_can_tx_poll(struct napi_struct *napi, int quota)
> +{

[...]

> +/* See m_can_poll() / m_can_handle_state_errors() m_can_handle_state_change() */
> +static int virtio_can_handle_busoff(struct net_device *dev)
> +{

[...]

> +/* Poll RX used queue for received CAN messages
> + * See https://wiki.linuxfoundation.org/networking/napi function
> + * int (*poll)(struct napi_struct *napi, int budget);
> + * Important: "The networking subsystem promises that poll() will not be
> + * invoked simultaneously (for the same napi_struct) on multiple processors"
> + */
> +static int virtio_can_rx_poll(struct napi_struct *napi, int quota)
> +{
> +

[...]

> +/* Compare with m_can.c/m_can_suspend(), virtio_net.c/virtnet_freeze() and
> + * virtio_card.c/virtsnd_freeze()
> + */
> +static int __maybe_unused virtio_can_freeze(struct virtio_device *vdev)
> +{

[...]
> +
> +/* Compare with m_can.c/m_can_resume(), virtio_net.c/virtnet_restore() and
> + * virtio_card.c/virtsnd_restore()
> + */
> +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
> +{


With this (maybe negligible) note considered: 

Reviewed-by: Francesco Valla <francesco@valla.it>
Tested-by: Francesco Valla <francesco@valla.it>


Thank you!

Regards,
Francesco


