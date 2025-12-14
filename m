Return-Path: <linux-can+bounces-5863-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 421CCCBB741
	for <lists+linux-can@lfdr.de>; Sun, 14 Dec 2025 08:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F5723003874
	for <lists+linux-can@lfdr.de>; Sun, 14 Dec 2025 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1132B2773C3;
	Sun, 14 Dec 2025 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5bQuarO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="trjcPp3k"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116983B8D5E
	for <linux-can@vger.kernel.org>; Sun, 14 Dec 2025 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765696847; cv=none; b=RYfcLCLuvvmU3CO1gtdJv2AyygYEtPTwVlkkESa2rBZb+LXkvPefAL2oztxK6Zx50R0CwRYkQO+NXXmGQBnnHBva67iaZ+/TzxxzoVBlflSUglc1uRYQ/x/WSfz83y4RwonnhtmzHUA+4Eopmr+7Pb90ar/Qme+UNLAmcL3FK3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765696847; c=relaxed/simple;
	bh=2Hruo867MnhKMXqnq2iboVj0I9z7FgOsV0vMzjLmKtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvZmhzWfyABzC8aqNYceFVP1cD5c+naKh18x82AFtLhtSWh/awRp3GG0iKkF1oPMlB2lTEyj8+dJ8j0v37UixVU4+D1wQxpZilyXQkDC0/HU2YUQshvXkIS/RFffjDzk56ZveEIN1HuiTufSw22GPXcx4QYbM26qlAL6N4VJZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5bQuarO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=trjcPp3k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765696843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6PBHGYUxi7Ek0lK+0qKl7f29nfdLGn+qwm8GebmaVpY=;
	b=c5bQuarOpJ2UOlXlohvJdw1NO4O6bK13QQ1oXPMrDf7wDZ9lF6aRfw2HoQ7W3x0I+151JK
	uemc0/5UOg57/29RC0Rht5ubp7xhiR/16frOP0YM5YUQ/VE8a8/tykS6SJQ5tb4Zm8Ghtz
	cKyabHTMPXR/MjNN+OLcWKOtJ0ONPu0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-vt-8hNaQMc2o5xyOFbqjxw-1; Sun, 14 Dec 2025 02:20:42 -0500
X-MC-Unique: vt-8hNaQMc2o5xyOFbqjxw-1
X-Mimecast-MFC-AGG-ID: vt-8hNaQMc2o5xyOFbqjxw_1765696841
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4788112ec09so16216275e9.3
        for <linux-can@vger.kernel.org>; Sat, 13 Dec 2025 23:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765696841; x=1766301641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PBHGYUxi7Ek0lK+0qKl7f29nfdLGn+qwm8GebmaVpY=;
        b=trjcPp3k9Co9RwAZQf21QOnJPjO0O5oKphSOsvON7lBGWfTM7l5kvyiuMSdr78ebTe
         7d0fUIfm84kDf02Ld1WIP3TvQZuN4QW8eexhRIKVUA9Fva28k4okwsBKkFMgv7pHq9Es
         ZKebhskObYdwkb3MQzwK94nUYr8bYpjD39ofxxjG4r+eKJkee1OwyX8z8avXf/MkmJ9l
         AmtrM+5m1yqYzj3MaPNEZmaYr/iTCnRk2TawqF46FJNGbMXtkeSpmTkyyh3FPOegGi4a
         c3PC0q3wIOP9lFWz46tX2OX06TZYKWO2Z+WpN+6qMSr39+Hku2J/NYSLo/4ja5oJ7S1R
         ARhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765696841; x=1766301641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PBHGYUxi7Ek0lK+0qKl7f29nfdLGn+qwm8GebmaVpY=;
        b=APl8acfaroiSOsfVmJ7EpyDe9y4Xw+7DPJKBAryDEDSYL/4TO8vvbXv82Ur2AUCVSd
         GG32P6caOuUztsGStFnyv4Rf9iOd39u0xJpmOhuYqhzORxOsl08aGQRb/g1VKqQVp3ev
         KkOBvt5S/hDgeaTRsgNyhQx2EG1BPqDKXevPJIBuEtIzhNt7YDTQuyg7jWp8sHcIMj/h
         eyZwOIKyDPt9Wx6pGvKgIfCt5OKmXjE4p03H6KHBOXvfw3n/cgM2TCizXtiWIcqvmDr2
         iJgmTL+3uxTi6ScBHdv3aAeyFcxtg1U72o6mCdfMSTRfrwuwCPniYqYB5Gy5+8bz1A4B
         jqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWZzHuajZ26kgu1hUqqNqyLujKf26UpksisvBFr1zxfdfmE5bjwE8FoMDQf2+gt8qybqyEyrOxIc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+Mw2kusrnoG56FqfyfOiFUQaGV9BWIYrZkkgSXHtFpv00D2+
	XrVc2FoE+2Bt5+3dcyqZ4O5fV36EnK8c7KPvjeK+5SbwfB6M1dYiUHf8ZDEYWoHkSq/o2zm/VdS
	vP8MLJA7RNGjfvir9m3KzaTBnyesDU/51ydw/ruNi2tBF9LeYl6gDEua1csNU6A==
X-Gm-Gg: AY/fxX7w/bKu2YyYHfAV/4ptSq03qBW0MHwRs/ofPgWmdj8LzGA2M4G70SLxcpk9xMg
	LW+G98ch3S1EPqiwcq3syvRKYZ+fK4LxSCv6e56ZhzOeZQqWhliwS/exwvAfrXML3uTfLji3s1c
	xS8U2SBp2Hr/LMiYjUDCQ4qqHaOs1e2XbEpQvGhamq1x7Qv16kx5hanQv98WWQSunR9TXH5YLk+
	B1YmGt8AFL6HlhSJfnkfSJuaaO1EEQ5/HzkHl0vwU5sOM9sfXYD1THfoJl4UtIw9pqrEEmRWVg+
	X7BGMVDG6mRDQVGfkG+vbQc5khYV8RudA1mqZiat4tykP9LEfxG/vo9M50kHTVR1nqHtTuE+D9Z
	HfhR3P+YrDK3ritIjc8jsPBczoPkuNdw=
X-Received: by 2002:a05:600c:1d26:b0:471:700:f281 with SMTP id 5b1f17b1804b1-47a8f90e561mr79551785e9.25.1765696841172;
        Sat, 13 Dec 2025 23:20:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+6ozxE+070hZaWXBVgyj/BNlykgsLXh8gS1Icmowaak4rF41B8W319InTAiQMPXUtjTWYMQ==
X-Received: by 2002:a05:600c:1d26:b0:471:700:f281 with SMTP id 5b1f17b1804b1-47a8f90e561mr79551595e9.25.1765696840640;
        Sat, 13 Dec 2025 23:20:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-32-59.inter.net.il. [80.230.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f7475895sm3073017f8f.33.2025.12.13.23.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 23:20:40 -0800 (PST)
Date: Sun, 14 Dec 2025 02:20:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
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
Message-ID: <20251214022000-mutt-send-email-mst@kernel.org>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTw2LORF0QiEcgM1@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTw2LORF0QiEcgM1@fedora>

On Fri, Dec 12, 2025 at 04:35:08PM +0100, Matias Ezequiel Vara Larsen wrote:
> > > +
> > > +	priv->can_ctr_msg.cpkt_out.msg_type = cpu_to_le16(msg_type);
> > > +	sg_init_one(&sg_out, &priv->can_ctr_msg.cpkt_out,
> > > +		    sizeof(priv->can_ctr_msg.cpkt_out));
> > > +	sg_init_one(&sg_in, &priv->can_ctr_msg.cpkt_in, sizeof(priv->can_ctr_msg.cpkt_in));
> > > +
> > > +	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, priv, GFP_ATOMIC);
> > > +	if (err != 0) {
> > > +		/* Not expected to happen */
> > > +		dev_err(dev, "%s(): virtqueue_add_sgs() failed\n", __func__);
> > > +		mutex_unlock(&priv->ctrl_lock);
> > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > +	}
> > > +
> > > +	if (!virtqueue_kick(vq)) {
> > > +		/* Not expected to happen */
> > > +		dev_err(dev, "%s(): Kick failed\n", __func__);
> > > +		mutex_unlock(&priv->ctrl_lock);
> > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > +	}
> > > +
> > > +	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
> > > +		wait_for_completion(&priv->ctrl_done);
> > > +
> > 
> > Since the call is synchronous, does can_ctr_msg really need to be part
> > of priv? Cannot be it allocated from the stack?
> > 
> 
> I tried to allocate in the stack but the guest blocks when during `ip
> link set up can0`, any idea?

you can not DMA to/from the stack, really.

-- 
MST


