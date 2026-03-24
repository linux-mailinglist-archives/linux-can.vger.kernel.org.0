Return-Path: <linux-can+bounces-7247-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKyMEobOwmnRmQQAu9opvQ
	(envelope-from <linux-can+bounces-7247-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 18:48:54 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2EF31A4A4
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 18:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64F543040AA4
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 17:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A283E9589;
	Tue, 24 Mar 2026 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZekPgF+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mWGVjj+K"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4CD3A1691
	for <linux-can@vger.kernel.org>; Tue, 24 Mar 2026 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374162; cv=none; b=ciHEHvdI1ScEYquIri9SyIJBt44uPt+tyZFW8JRv+92VVci8VFBGqIEcOwq0ee+7J0UYf2XRZOsawO85g+E2iqsz8GKIlyaf35256h1FsnQSsoQ/hkyIaOX/fqWxdP2+tiHeTNFvvGxYMFp85eOYPyhYZNlIiOvXrrj/OwULKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374162; c=relaxed/simple;
	bh=TJyvrr4HaLk8h/xrwfw3is3omZUyp+y5i6BcRF5lQPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODIknc4asc0VcWH65YrTk6dWxztzt1uaqgof69YIvPQxmkdbqIJUdxxs2ooA9jm8rPIAaIZeIfNO9Bavr7z4YAj9JwbstiGMRAwxT6vecVY7kWGUaeconZ1C5mlTJNO3OR4mJ7jMNhq6eRyLFklIz1zis7WkCjLnaDYfVj3530M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZekPgF+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mWGVjj+K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774374160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8hqPRba6xj486YSVHnHmVBfkPNRQNNSk9RXrPw+XUY=;
	b=XZekPgF+JJruPLDcv3U9lhOGZ7YoxTvVbQzFR12mIRaj12Dj8mOQDyzx6Cjg2XcKXVtgRp
	5mlm5mlpVa/HgsHO83aDrANNFUEMRuk/GG7bUY8LY0ZjSLbHoM6FMQU3l74LDwp08PpwZ2
	8RYgL2ychByPC0jCjydH1b9D309C6xw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-aXuQw3aHPredOtNSWUv10g-1; Tue, 24 Mar 2026 13:42:38 -0400
X-MC-Unique: aXuQw3aHPredOtNSWUv10g-1
X-Mimecast-MFC-AGG-ID: aXuQw3aHPredOtNSWUv10g_1774374157
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fc42c83aso17393915e9.0
        for <linux-can@vger.kernel.org>; Tue, 24 Mar 2026 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774374155; x=1774978955; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k8hqPRba6xj486YSVHnHmVBfkPNRQNNSk9RXrPw+XUY=;
        b=mWGVjj+Kmq0K0rrO8oFyYCRzYaIOxnZ2X+nfzL1U1htenEDFkb+3UZclbrYQzuX6Ns
         Q3owdpWxkVrql3Dgb4qOdLyMJRXgjHor6BlgXlpOmXFFB+aanZFBt0S9IzhK5LDG0nww
         +CfJEJCwqbRo69VFNX3oX7GJHhmuPgeGXe+fI3ICFhsgc/EE42p40IKwZ3rkrUmb5ZWb
         MACtMOQNP9XAkkgrIwoX7gvsUL1HTq95StshQx02b9deLxhxaEjNjUR0ssWRUiXAeXlA
         X4Ju+ieLMJMrnnGmLMuiplCSgF/NdIxHlJsCGxctHC0n6zQp9EM3ej1IAzjXMXM+crIg
         55jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774374155; x=1774978955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8hqPRba6xj486YSVHnHmVBfkPNRQNNSk9RXrPw+XUY=;
        b=Rh/7VnKGhGpgHAuxKgmgVDv38mIkKuczyPYmaJLSLwDDuDf/U8YSo6RrRcNTgNZsYG
         RM0AEXKa6KKzFuajwG1ovcVYQRA9cxxGgI4IQ5FOSJKId6emG59tevn6tcZafM8GjGZ8
         GPFgqzLmFCnf0J8xw7YPmMQdNgM3dSOJGJspk/ysHEMB/8nMWj+L63Bif2iXsfzRG7Jx
         SarvCqXde6ZXUpyIa3wUJV1KkAYFHy2FEynFqE4LEMCGH38Hjh0JNLdTqmyAheUPY2xA
         84GLwiQOZQYr2Hoz9BRVYsB/qsMVgJ5jiGN9c/erI6notXaZ7kOcWlISeBUFJqmhxZ9i
         IDKw==
X-Forwarded-Encrypted: i=1; AJvYcCXGaKOz+u5VILpDjTkbyx9LWhQr663NYfmMgOwkFSdUQEb433khxKG6rUgL8e3Z6bauZxxLI05Ewzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWUucOrtIA9iV2xr62FIy1du8uSB8P/UNCTArJu0iNlAd2jAs
	BlL+TuCCD+jkr8I0KGnHIFHwSk8VmKult7x8McNFdGrcLKJeiHhT7J+pSiJEJyiy6NqfOZ+ywKy
	2CX+pfK+GTtkQp/QncqcbngEeQAFSB5eClMsf5KtqiJEwvo3z+IGamdCeMPNzcg==
X-Gm-Gg: ATEYQzxxBjsLvMXXQjqGTcS5AIu/qsozpXEX+V2Abk+9MTThwou0HLWSGIG8rysM6E2
	6BzkbWvLPhD2Blgg1RbOEwah1+PnkGemfOcrKlxgIVrkzuWpFMSB/0KM1h3FSTR5k/XzBRG2U0L
	G/qN2GJ9dforIcHG9XUCqoGFG40FNRP/GZ7Tf/59iCNrUYgQ4T0l/Y5tKKqjMWqgSFblzx5q6cV
	R6cTg3IwSzvqLWP6bdVt+IsxbfqrpW0pJd6iO5T2hmnWxhw1yiMrNXbrwW8o7X5Kpg4arrjhsUQ
	13Frt2uJH0bQyGBD386F/l3LlBgKZ/ykK5pDdgZC/QjIxhxves9BdQa/STMiBkRZ2JYNvfzITww
	nAslYCtBR/5HNnyc=
X-Received: by 2002:a05:600c:4705:b0:485:3dfc:57d with SMTP id 5b1f17b1804b1-4871608481emr9678895e9.30.1774374155072;
        Tue, 24 Mar 2026 10:42:35 -0700 (PDT)
X-Received: by 2002:a05:600c:4705:b0:485:3dfc:57d with SMTP id 5b1f17b1804b1-4871608481emr9678495e9.30.1774374154616;
        Tue, 24 Mar 2026 10:42:34 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716549160sm3084885e9.3.2026.03.24.10.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:42:34 -0700 (PDT)
Date: Tue, 24 Mar 2026 18:42:31 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-can@vger.kernel.org, virtualization@lists.linux.dev,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v13] can: virtio: Add virtio CAN driver
Message-ID: <acLNB9PYmJ9L0Wvc@fedora>
References: <ab2FlQTWUxl0KmlT@fedora>
 <20260323-hilarious-active-eagle-a0ee74-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323-hilarious-active-eagle-a0ee74-mkl@pengutronix.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7247-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mvaralar@redhat.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 9A2EF31A4A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:36:18AM +0100, Marc Kleine-Budde wrote:
> Hello,
> 

Hello and thanks, I am struggling to come up with a solution for this
comment.

> The nipa/ai-review bot found these problems:
> 
> | https://netdev-ai.bots.linux.dev/ai-review.html?id=b046d75a-2de1-4063-bb96-8f64abc65e7d
> 
> commit 0f3cb3b3bc94eaff9b9709b528e498fe6150f9c1
> Author: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> 
> can: virtio: Add virtio CAN driver
> 
> This commit adds a virtio CAN driver implementing a complete CAN bus
> interface over Virtio transport, supporting both CAN Classic and CAN-FD
> frames.
> 
> > diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> > new file mode 100644
> > index 000000000000..57641c3ed6d0
> > --- /dev/null
> > +++ b/drivers/net/can/virtio_can.c
> 
> [ ... ]
> 
> > +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
> > +{
> > +	struct virtio_can_priv *priv = vdev->priv;
> > +	struct net_device *ndev = priv->dev;
> > +	size_t size;
> > +	int err;
> > +
> > +	napi_enable(&priv->napi);
> > +	napi_enable(&priv->napi_tx);
> > +
> > +	err = virtio_can_find_vqs(priv);
> > +	if (err != 0)
> > +		return err;
> 
> What happens to the enabled NAPI instances when this error path is taken?
> virtio_can_restore() enables both NAPI instances at the start, but if
> virtio_can_find_vqs() fails here, the function returns without calling
> napi_disable().
> 
I was expecting that, if virtio_can_restore() fails, then a successive
virtio_can_remove() will not hang in napi_disable() since the napis were
already enabled.  

> The corresponding virtio_can_freeze() function disables both NAPIs before
> returning, so the restore function leaves the NAPI subsystem in an
> inconsistent state on failure.
> 
> If the PM framework retries restore after this failure, the second
> napi_enable() call on an already-enabled NAPI will hit the BUG_ON in
> napi_enable_locked():
>

Does the PM framework really retries if virtio_can_restore() fails? If not, that BUG_ON
is never reached.

> net/core/dev.c:napi_enable_locked() {
> 	BUG_ON(!test_bit(NAPI_STATE_SCHED, &n->state));
> 	...
> }
> 
> In contrast, virtio_can_probe() enables NAPI only after all setup
> succeeds, avoiding this issue.
> 
> > +
> > +	size = priv->rpkt_len * priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free;
> > +	priv->rpkt = devm_krealloc(&vdev->dev, priv->rpkt, size, GFP_KERNEL | __GFP_ZERO);
> > +	if (!priv->rpkt) {
> > +		virtio_can_del_vq(vdev);
> > +		return -ENOMEM;
> > +	}
> 
> The same NAPI state issue occurs on this error path.
> 
> > +	virtio_can_populate_rx_vq(vdev);
> > +
> > +	if (netif_running(ndev)) {
> > +		err = virtio_can_start(ndev);
> > +		if (err) {
> > +			virtio_can_del_vq(vdev);
> > +			return err;
> > +		}
> 
> And again on this error path.
> 
> Should all three error paths call napi_disable(&priv->napi_tx) and
> napi_disable(&priv->napi) before returning the error code?
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



