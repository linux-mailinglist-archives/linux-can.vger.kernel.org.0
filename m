Return-Path: <linux-can+bounces-7344-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMlRDjgN1WlQzwcAu9opvQ
	(envelope-from <linux-can+bounces-7344-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Apr 2026 15:57:12 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1143AF937
	for <lists+linux-can@lfdr.de>; Tue, 07 Apr 2026 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9551730DDF5A
	for <lists+linux-can@lfdr.de>; Tue,  7 Apr 2026 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFA53B584E;
	Tue,  7 Apr 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKZyJe9D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="irsCV5Vs"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8083A3E73
	for <linux-can@vger.kernel.org>; Tue,  7 Apr 2026 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569737; cv=none; b=V1/VRXiAOes2o+qOpgsEvnpW8NxXWd9jwEeAof5NT7qdBK0k6cP/hJ67j+7yJHP8WZMHznA5S+8L+kBxjl3DXPENzk3GwrFqX6EhG7qygakOU9FTCD8IgE9V3aG1zrYItnm6oIYm7bKvlQnTEWzjQAeRjS5mVJQ/TKmjJ71b1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569737; c=relaxed/simple;
	bh=ku//Og96honEKfqlO6IFIyTkbq5vfNMlseA4tBULPUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVeR9ZOjafiChJbI5aMSMENq7Gu8bL/u/d1YzPZE0uMo9jOdZZ6L/c6lVgjz42z3f+7K5OfakIqWpg7wrt+hxIfeoiAj4thHoXzteWefz8o/SbeWZz102FPHwB4qR0fGBJPVsjig1/bXr2SIWx5wr5GmC+HnO0nKdFHbJbrUBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKZyJe9D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=irsCV5Vs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775569734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SemPS/ErL+EkevTHIsXEII6ZD+AkVr3URBNYDRGp7Q=;
	b=VKZyJe9DiylRorzBRcnY5xBvkBB5TLowIo1ydYwZlamyGa+TSRgPNAodqh9Ep1/UchnZlj
	juu/caEZqrpWlG/qQfwGloKmvpxMzgsgn8oFM1yFMOJDoFUGkAgYQl/qVAri9LbeCOqekX
	ASHQm4je5F3NM43UnLTucX3gRre7rtI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-LMXWOeeQM4CHp3Sbdsijlw-1; Tue, 07 Apr 2026 09:48:53 -0400
X-MC-Unique: LMXWOeeQM4CHp3Sbdsijlw-1
X-Mimecast-MFC-AGG-ID: LMXWOeeQM4CHp3Sbdsijlw_1775569732
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488bf01961cso4805825e9.0
        for <linux-can@vger.kernel.org>; Tue, 07 Apr 2026 06:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775569732; x=1776174532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1SemPS/ErL+EkevTHIsXEII6ZD+AkVr3URBNYDRGp7Q=;
        b=irsCV5VsOoDmog5LLxcBUMfiYqsnmZ40v5Ar/To8ZLY5OqxXmBBUt67rvo1shgaB54
         zCQ/Fe3MNvZ2MgTE8cof9iMqKyrahCc1455ByGtKsCtsz8hTISCBdC1BiFn8qzpKEUu+
         KmgpHJkVOZTvhGngkQ9aRH9OHfKGoC7Ap/mcx/9V4PvZDkv4uGRI/NsdkoThLZNs9kyq
         i/EqOc3N8ukoGm32BX6fBh71tUEmtEWHmAIP5GV8Rq14t2r79g+DotsXxIopmr1xYcZb
         13voA67VM/g6cjRea+Tjsspat4ZC91HZCYJALVEuHUMhwpnno81e0L4aIcnoAeElfojD
         bR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775569732; x=1776174532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SemPS/ErL+EkevTHIsXEII6ZD+AkVr3URBNYDRGp7Q=;
        b=QMGAsvdCLveDOnQAFqnnTbXy8adofREKhjDRQRx65hSyWx9TFXj4B4zqLqaDtrz0Bp
         SYIbapuilmsnXR6JifqQ8wg9v+oGBBwnqRyUp4R+aIKzPvshdoCms3qVXhafR2C5JffF
         jVuZhN3LH5cSJPydwTqMhVFo452F8MxfzyCM1tvNvmEcaiv4U7wDXkcFwxT/jJcLYywZ
         ciC5Z5Ivu/ixvdvnx9l17gVNE0ZV8LSBTWt3GVv980uOW4plgOzNCyeUl4cGU6Z1o+mu
         pwN78+Zn79uM7eT5MzZCXh+idJzucAvFKZx3lUace9oIFOr1eon2CgqkH1yFqECX6ph6
         VvZA==
X-Forwarded-Encrypted: i=1; AJvYcCVzXR4Wo2h0ryQJpppYxG/x7Q3TxIHmKruHfEgrZy1QL+qitLaOzWljH6l/xEMz2Q/ej2aKHRbY4aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlBuFQUgSSvYl2p9y68t1hgDntdgm1VvWQfMKoWED6yHwUd+O
	co+tQ1Ow73oh9XxvY8Xg1xJjLzmkVYKhWv0WmhJvvrVUOS8wjdw7Tpto089IiiwM9kFDrQU9L3R
	+wlNuCKxqX0QMn6p8JrLzByrgCR5u3gVxloCuRtJYAoR1ngPGvKggOlIh0E7VIA==
X-Gm-Gg: AeBDietAPbwuoP5ReC2+sNJGg3ezFC0GKB3FA7lIlQgXtyPEDCFnVhXNMJoTP8ZFMUa
	YcQccycSIaGFIKK/dCZqJqftyXAbKQeLiVQpq7JCj9mX+YtIWIo1rwFY0MzzVcVOZ47+KRHPz4T
	krOYxU4TY9FgCLHMZYKo0OaacEbpBtz+j9oj7LwQSzxcagWZcHCqGR2IEvb7eRvjm2dgzSrC8Pb
	cz9TqH/v3qiZCcK9kszNK9XHMZUX9AYEZ1G/7R/Dskq8aGB1nlp0jnSdr3sKPBAQTcbcPe0Wi9z
	irilyUqq/+mkqPSEWC9F8VJoHDFEXKuxRvInL64tEkCrZXKpNqmRNr2jPxknoMxc1NcSuoR8dNC
	a/1ghV/DY4Srvj1I=
X-Received: by 2002:a05:600c:638e:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488997dec25mr231622915e9.27.1775569731573;
        Tue, 07 Apr 2026 06:48:51 -0700 (PDT)
X-Received: by 2002:a05:600c:638e:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488997dec25mr231622475e9.27.1775569731074;
        Tue, 07 Apr 2026 06:48:51 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm543792925e9.12.2026.04.07.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:48:50 -0700 (PDT)
Date: Tue, 7 Apr 2026 15:48:48 +0200
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
Message-ID: <adULQMZggR9M/Fgx@fedora>
References: <ab2FlQTWUxl0KmlT@fedora>
 <20260323-hilarious-active-eagle-a0ee74-mkl@pengutronix.de>
 <acLNB9PYmJ9L0Wvc@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acLNB9PYmJ9L0Wvc@fedora>
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
	TAGGED_FROM(0.00)[bounces-7344-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,pengutronix.de:url]
X-Rspamd-Queue-Id: 7D1143AF937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 06:42:31PM +0100, Matias Ezequiel Vara Larsen wrote:
> On Mon, Mar 23, 2026 at 11:36:18AM +0100, Marc Kleine-Budde wrote:
> > Hello,
> > 
> 
> Hello and thanks, I am struggling to come up with a solution for this
> comment.
> 
> > The nipa/ai-review bot found these problems:
> > 
> > | https://netdev-ai.bots.linux.dev/ai-review.html?id=b046d75a-2de1-4063-bb96-8f64abc65e7d
> > 
> > commit 0f3cb3b3bc94eaff9b9709b528e498fe6150f9c1
> > Author: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> > 
> > can: virtio: Add virtio CAN driver
> > 
> > This commit adds a virtio CAN driver implementing a complete CAN bus
> > interface over Virtio transport, supporting both CAN Classic and CAN-FD
> > frames.
> > 
> > > diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> > > new file mode 100644
> > > index 000000000000..57641c3ed6d0
> > > --- /dev/null
> > > +++ b/drivers/net/can/virtio_can.c
> > 
> > [ ... ]
> > 
> > > +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
> > > +{
> > > +	struct virtio_can_priv *priv = vdev->priv;
> > > +	struct net_device *ndev = priv->dev;
> > > +	size_t size;
> > > +	int err;
> > > +
> > > +	napi_enable(&priv->napi);
> > > +	napi_enable(&priv->napi_tx);
> > > +
> > > +	err = virtio_can_find_vqs(priv);
> > > +	if (err != 0)
> > > +		return err;
> > 
> > What happens to the enabled NAPI instances when this error path is taken?
> > virtio_can_restore() enables both NAPI instances at the start, but if
> > virtio_can_find_vqs() fails here, the function returns without calling
> > napi_disable().
> > 
> I was expecting that, if virtio_can_restore() fails, then a successive
> virtio_can_remove() will not hang in napi_disable() since the napis were
> already enabled.  
> 

Ping @Marc Kleine-Budde, do you have any comment about the comments
above?

Thanks, Matias

> > The corresponding virtio_can_freeze() function disables both NAPIs before
> > returning, so the restore function leaves the NAPI subsystem in an
> > inconsistent state on failure.
> > 
> > If the PM framework retries restore after this failure, the second
> > napi_enable() call on an already-enabled NAPI will hit the BUG_ON in
> > napi_enable_locked():
> >
> 
> Does the PM framework really retries if virtio_can_restore() fails? If not, that BUG_ON
> is never reached.
> 
> > net/core/dev.c:napi_enable_locked() {
> > 	BUG_ON(!test_bit(NAPI_STATE_SCHED, &n->state));
> > 	...
> > }
> > 
> > In contrast, virtio_can_probe() enables NAPI only after all setup
> > succeeds, avoiding this issue.
> > 
> > > +
> > > +	size = priv->rpkt_len * priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free;
> > > +	priv->rpkt = devm_krealloc(&vdev->dev, priv->rpkt, size, GFP_KERNEL | __GFP_ZERO);
> > > +	if (!priv->rpkt) {
> > > +		virtio_can_del_vq(vdev);
> > > +		return -ENOMEM;
> > > +	}
> > 
> > The same NAPI state issue occurs on this error path.
> > 
> > > +	virtio_can_populate_rx_vq(vdev);
> > > +
> > > +	if (netif_running(ndev)) {
> > > +		err = virtio_can_start(ndev);
> > > +		if (err) {
> > > +			virtio_can_del_vq(vdev);
> > > +			return err;
> > > +		}
> > 
> > And again on this error path.
> > 
> > Should all three error paths call napi_disable(&priv->napi_tx) and
> > napi_disable(&priv->napi) before returning the error code?
> > 
> > -- 
> > Pengutronix e.K.                 | Marc Kleine-Budde          |
> > Embedded Linux                   | https://www.pengutronix.de |
> > Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
> 
> 


