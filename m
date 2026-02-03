Return-Path: <linux-can+bounces-6483-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNl+BHEhgmmQPgMAu9opvQ
	(envelope-from <linux-can+bounces-6483-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 17:25:21 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E084FDBE6A
	for <lists+linux-can@lfdr.de>; Tue, 03 Feb 2026 17:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4778630C27D4
	for <lists+linux-can@lfdr.de>; Tue,  3 Feb 2026 16:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94FB3191B0;
	Tue,  3 Feb 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qc7BAZLY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu3Drpia"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E18E175D53
	for <linux-can@vger.kernel.org>; Tue,  3 Feb 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135644; cv=none; b=QdRSqQCfO0c/wkX4pEhNLM/bCPHmjtyUPAgcknp3UZObADszLfX8CGHVGv3WhIwo/yHj+olZ++QiS89fGC6XBZyyBb7PkCDlL3HI8xDnUB+s+c8hfdLLZTJJw3gG0o33ZerqonMpkM/UmZpMzFRxStP1gAqQErgrSd+5d7S4exc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135644; c=relaxed/simple;
	bh=gADRKLw82C+tfxUEYY3hlWKJfxUSp+EMySsSF1+SVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P//YVmxevIS0HupTrbONLAxot9fhOPbum8b5eHlJAFYUOMtO0Vvjh/509WNmwyUvy7fQlZVvhg69Xf02kDPc/M+GdaSAp1ut+wXoLEg+LTnqZKrecORKEIDdw1d3DgWixENh7C4SkMYnrNCMlYuclpvloROEo2OWcgwBnEHAvzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qc7BAZLY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu3Drpia; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770135642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhlncAUQMkbq0DxIaSpkvI2sfDCod5hPiXP+UVdbqP8=;
	b=Qc7BAZLYTNGgPWKQ1Feuebd31Adz/BOD4SW0JnIXHQUaS4348402tMc9gNzlvde034qJLv
	tBqNdkLe5+4iP9adunyhPezy3VZW1LV/8Sv6T+6pJPJOyyj+S4exdlvTaj1S3NR6xhmX86
	nEQptJOtTtyN51lTQTY/MCYsoVuksqo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-JwvtjEkbMO2EVxLzczkU2w-1; Tue, 03 Feb 2026 11:20:40 -0500
X-MC-Unique: JwvtjEkbMO2EVxLzczkU2w-1
X-Mimecast-MFC-AGG-ID: JwvtjEkbMO2EVxLzczkU2w_1770135640
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-659318dbb6fso1401345a12.3
        for <linux-can@vger.kernel.org>; Tue, 03 Feb 2026 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770135639; x=1770740439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhlncAUQMkbq0DxIaSpkvI2sfDCod5hPiXP+UVdbqP8=;
        b=Pu3DrpiaMwAWSozatanOCXur3dqnzhOrQOdqmyEI+aKwjBHi2EoUohlepWE9nHVfWz
         gRUaFf7EyBA3Ko8hW4vEVxyXKgcca3r2WUqogbndGCoAP+RqOdSSc9o3WcRiJNWE/pGK
         LeBgVZC73s38WSmLoU1c1BjzklJ85UcaQIXXYz6czM/W5FXrq8nnFLLg/vX+a6sFnNwO
         NjeDt3WbuHg/LD+RO6G02GkTk3V3WtE7lr98xliovmn9eT/w+R96EybqHCqgzMPSbNL8
         2d5D+GrAgYVLpEksufjxHENtqEdMixCf2DMY7ssEhig/1Nma3UdSsTkqSSde84lBlKdF
         6Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770135640; x=1770740440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhlncAUQMkbq0DxIaSpkvI2sfDCod5hPiXP+UVdbqP8=;
        b=bg0liHDWmcROFWbn6EKhA08jIyeTwkQsAiGmLFUmKSN0Y6B2eBRcZIXUCRGo++qshn
         4m3rLpjU4Mx2X7IVQcP+vs9gpPaxNC9/kriYqJ1SSs/JBlxkzk3ZH+F9ezoLr0yVAPVf
         FO7F+AeoC7wekp/oiiwc0UrORE+gw4WSt35SfEy6+Ts45ml7Mp3GE5a0KVrHoU3/wMvX
         GvPW+IxjdV5/vJ8uGowPjPG2WT0twSYWEop0S2tcT9DU6WNYYCrBAr7Vx8FKYrUpG5kS
         sWOfs9OhJa9nQGUJrKMrLdDHiPpEmtWibChcRlZSvd9GgSl0uUS+nFWLPeeIr/D2r6WT
         GCUg==
X-Forwarded-Encrypted: i=1; AJvYcCVzhftb7EvS8NYK6oB19bj54FU/Q737yJRRYtiqo1bkZygBmVZHTa1ei/rKXZvphL8na7k9sojf4rA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2urbLSQhC4umJ2cuMl+kRZbP/qoveXqs5hIfn/Gr6nSqXDe+
	VHdB9shiZQFI8w8mF1OoERFkebLDOoauzlZl7wqBTw0Z9tu5xNhhtM/6obW+JphZw3JcwN6LV6q
	IzGSot7FnnEzdgLOECYXfOlzw+r//0DcSSj77BPH6DOglP/d+BysGZmvathxcYw==
X-Gm-Gg: AZuq6aKyY6Ju/ysGXu1JXjj7wKU/BDPvvdK9HLn+lEbYeCAePmhSJEsGQrE+d0ideWl
	kPYCK9ibBpGvEMZUZF8TjT8AM0g34zvOgwZyu4lKecEFXqmDCXsOmD8KtZ6BSjnY/m0Y+HJ4Try
	4i4MV6i2lPKCA9XfMczj8ssMFGBWu56tYm5VwOzuWVCPBwmh3mR331kh0WBPuUIN8ZCgULR+JTY
	g4GmqzVo1aR9hOTLAXunobNZxRadaROA9qNkaEzLmjrp8AMS31bhTRJLOBaxn+TKegOIaFOvg4T
	E8EMz5l7CdnW2c4rSYO+hfNQRQ1DRXqtRYIROHKu3+/PofRdHNMm6RwhRIlB9h3IpOLVPrMjjkQ
	zG/9UDh++9ElWBnq1GCyABZm3LOOXse5xSQ==
X-Received: by 2002:a05:6402:4413:b0:653:7bdc:9561 with SMTP id 4fb4d7f45d1cf-65949bb66d3mr133792a12.15.1770135639545;
        Tue, 03 Feb 2026 08:20:39 -0800 (PST)
X-Received: by 2002:a05:6402:4413:b0:653:7bdc:9561 with SMTP id 4fb4d7f45d1cf-65949bb66d3mr133772a12.15.1770135639048;
        Tue, 03 Feb 2026 08:20:39 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65949fd80a7sm49935a12.14.2026.02.03.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:20:38 -0800 (PST)
Date: Tue, 3 Feb 2026 11:20:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Francesco Valla <francesco@valla.it>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v7] can: virtio: Add virtio CAN driver
Message-ID: <20260203111926-mutt-send-email-mst@kernel.org>
References: <aVwGfOlvRqdv5xj7@fedora>
 <aWE5duyvXCuwsMAn@bywater>
 <eec1a83b-e36f-47bb-9a5b-6888b42e063a@oss.qualcomm.com>
 <20260203070338-mutt-send-email-mst@kernel.org>
 <5d9645ea-41b8-4904-abbf-3b201183e2fc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9645ea-41b8-4904-abbf-3b201183e2fc@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6483-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E084FDBE6A
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 04:18:09PM +0100, Harald Mommer wrote:
> 
> 
> On 2/3/26 13:05, Michael S. Tsirkin wrote:
> > On Tue, Feb 03, 2026 at 12:55:07PM +0100, Harald Mommer wrote:
> >>
> >>
> >> On 1/9/26 18:23, Francesco Valla wrote:
> >>>> +static u8 virtio_can_send_ctrl_msg(struct net_device *ndev, u16 msg_type)
> >>>> +{
> >>>> +	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> >>>> +	struct virtio_can_priv *priv = netdev_priv(ndev);
> >>>> +	struct device *dev = &priv->vdev->dev;
> >>>> +	struct virtqueue *vq;
> >>>> +	unsigned int len;
> >>>> +	int err;
> >>>> +
> >>>> +	vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL];
> >>> Nit: consider initializing this above, while declaring it.
> >>
> >> All those "Nit" regarding initialization cause problems. There is a reason why it was done the way it is.
> >>
> >> The network people require that the declaration lines are ordered by line length. longest line first. This is called "Reverse Christmas tree". Don't ask me why, this formatting style is what the network people require. Their subsystem, their rules.
> >>
> >> To initialize the vq you need now already the priv initialized. If now the vq line becomes longer than the priv line you will violate the special formatting requirements of the network subsystem.
> >>
> >> Solution was: What you see above.
> >>
> >> Regards
> >> Harald
> > 
> > So you reorder it then:
> > 
> > 	struct scatterlist sg_out, sg_in, *sgs[2] = { &sg_out, &sg_in };
> > 	struct virtqueue *vq = priv->vqs[VIRTIO_CAN_QUEUE_CONTROL]; // priv not initialized, will be done too late in the next line
> > 	struct virtio_can_priv *priv = netdev_priv(ndev); // you see it?
> > 	struct device *dev = &priv->vdev->dev;
> > 	unsigned int len;
> > 	int err;
> > 
> > 
> > and where is the problem?
> 
> The problem is that you use priv here to initialize vq in the line before priv is initialized.


Got it. Ignore the tree thing then. It's a guideline.


> > 
> > On the flip size, this guarantees we will not forget to initialize.
> 
> Static analysis is your friend.

And then someone monkey patches it to = NULL or something else silly.
I prefer correct by construction.


