Return-Path: <linux-can+bounces-6024-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4123CFF4BF
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 19:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D8B359A221
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFD034E74D;
	Wed,  7 Jan 2026 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxCDfs0M";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mEXhK2K5"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC8B35A951
	for <linux-can@vger.kernel.org>; Wed,  7 Jan 2026 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802489; cv=none; b=lCTsm3KVkHyTp5WQEmTLdKj1OLXJm2fegU0SIpGnoifYtm1qxr0jvS9vQjcC5wv1LrLuT3nXArDDLghMoSlTJna58TyGf3aHltZsHxmQLPGTcaLGqjxdeK4UwL5WeYm23HxBCJ6VhI3x1R43vwUTpR1t2GyCQjGOSzJwVupP6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802489; c=relaxed/simple;
	bh=4Bf2zwdKuMQPmjyomvCRiDRso9p7R/TYGKy2hGAhLa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PenEbRXXdTpN/zDSXHT0YskXCiJyCId20fUzqURCRppJoN2d+vdehFcS73NsQbcqgNa+uI1xz5QNqnmroUWidBoc8gshxfkpBLfqwXRWYqyIvd9xbfxfcFXuVWM5Mk2JG/e6GDt6+v3BG1xRQ33cvZ5VzMeIurSxLOEnS4EM4TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxCDfs0M; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mEXhK2K5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767802480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7TulDsUIoUUXsalob4NbrEsky01/JB7jW1KypFdcu0=;
	b=SxCDfs0MaSPRVkBgkylBrn3/WzvA/+nKSwSbf5BBoNawT7T6Ve+PLEMZitNIzZ6eOLe8nE
	XmoZs8VPPMgtpqxNHgdMQTR710UZo+AlnYm9Hz5B9jF3oEEBWK4nnCsppgFAJ6/pS0FabQ
	+8ya04LRQI8f2gtDCj6aUt4LxLYfhKA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-kZaoGD6qO7aDZdkkNr4n0Q-1; Wed, 07 Jan 2026 11:14:39 -0500
X-MC-Unique: kZaoGD6qO7aDZdkkNr4n0Q-1
X-Mimecast-MFC-AGG-ID: kZaoGD6qO7aDZdkkNr4n0Q_1767802478
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b841fc79f3eso226810066b.2
        for <linux-can@vger.kernel.org>; Wed, 07 Jan 2026 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767802478; x=1768407278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7TulDsUIoUUXsalob4NbrEsky01/JB7jW1KypFdcu0=;
        b=mEXhK2K5LlLKSXoKGwfJqXzJO/k0jIVXTACiCnV99jDYTJSByUjz74tBUhbQl8l7Ik
         w4PVqAyZ/cf1F7rY5Sr4e1bKwiiyHLCEenvrE189olsUpFfmhZD11oRjFALkkPgrb+WH
         mStpcQjMIgwzUTq1LvJecf1/SzE1K6X3tg/PgPf1QslyvpnzelLjbqMgHxGPltF+tqVm
         4mOOASpTpq9Ep6c1QWyWSuxLBbho63RYJXytlNw+YlcKOJ2QCPjomRjZb0vvvnME62CJ
         0Ye7qsFIbACbO7yWABXc6h0lUaCuhyIJeWZXeDhA7GYwJEe8uf+KgXiQRtKPLFagM14C
         qh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802478; x=1768407278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7TulDsUIoUUXsalob4NbrEsky01/JB7jW1KypFdcu0=;
        b=TimiwSBdVJq46DRuITX5LdGxhvlOUtwlSrvNh+TxNMnPHxyIsRDdF7PYUglG2nXgeM
         36PAuQ26UBvpC/tq5PInHHgYT2R6fXuv6cUD2NK8v/iVxG/4JqbRQqt0hRdePjNEZZl+
         WItXolFfIJlyfXfIVLki4UskH4xOCqXZel/h1z8DlLb2042zNsRq6R+4rHVAEn+FO1mh
         GBx5JljNz1tlJyUapDSKCOp/CU3UUJbnrwTr2yoB6mLNYmRqxNqMuZgvHBxuKl83UFnt
         F1j+qKkWDmF2ImDvPtC+DtXhJKbTYhdFQVjqkTR7i/oenO+s+0HSuVd4/4OkI2Ebe0rZ
         3Iuw==
X-Forwarded-Encrypted: i=1; AJvYcCWzTvaJpCxgM+5bGRXM08LnznnOtDRNs5Dh6lq1ZkHdh0HxqOtFyYcv2qhSuiMwn14TXeTZzA3eu5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBeS+749hhOyofvBaT2PNLWYpyefXoKIRa6LI40ckwHSP1INp
	Bsiv8P0etK4osPw1s7E7tzYEK2QVUOt3qUZxeqvY9WmTgJ+p5/f6xuXfAy1IWaTWHBuU5Jxhq4y
	S5aVBsXlCBaVhS1dSi7y9ZgLG5A5H9HXxM1xN1T834/sASvV3DJUiUsrCZ7ZGv8bLCsIztAPm2q
	ZRmvLzzGALZPgoXneB1zS3iWlOPyaBql3MZNsA
X-Gm-Gg: AY/fxX4uLEPioULe+ydBQ3AWGE9ezE9zJN/uZALmc0/MaEdkSZQjdf/q09fBadI7KOO
	EFU+9mO3/QvJ/6o04P238y6GdJDR3XlxMh5mirlnZEm7XPOh6igBCH5Z0k07V5w9YB1A5C/V+TL
	FDSaxkVkmXqg3PH10F4VV38wvNum35ydzNGrFUstxPM+n2ChARN6gdGiou53c0asVCLtuF0qV5e
	183ZSNs6LTV0/8X/RGXrOag
X-Received: by 2002:a17:907:d8e:b0:b7d:266a:7728 with SMTP id a640c23a62f3a-b84453695d3mr284848066b.44.1767802477674;
        Wed, 07 Jan 2026 08:14:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElzm7zkv7ZclGZmqUlhgAe5G5tLnSradBGNYxt46392ibtMetTmULGCAhQlqjI1V8VHmLYzPP/1+tnQ3XTs/k=
X-Received: by 2002:a17:907:d8e:b0:b7d:266a:7728 with SMTP id
 a640c23a62f3a-b84453695d3mr284844566b.44.1767802477239; Wed, 07 Jan 2026
 08:14:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater> <aU6lCL_vrF93lpYa@bywater>
In-Reply-To: <aU6lCL_vrF93lpYa@bywater>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Wed, 7 Jan 2026 17:14:25 +0100
X-Gm-Features: AQt7F2rxsUoKHks-6LhmwpO5LgspFNWkVaIpGX4dwhn6wdf4jpflCBL5LBTJN7E
Message-ID: <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org, 
	virtualization@lists.linux.dev, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 4:09=E2=80=AFPM Francesco Valla <francesco@valla.it=
> wrote:
>
> Hi,
>
> On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> > While stress testing this, I noticed that flooding the virtio-can
> > interface with packets leads to an hang of the interface itself.
> > I am seeing this issuing, at host side:
> >
> >       while true; do cansend can0 123#00; done
> >
> > with:
> >
> >  - QEMU: the tip of the master branch plus [2]
> >  - vhost-device: the tip of the main branch
> >
> > and the following QEMU invocation:
> >
> > qemu-system-x86_64 -serial mon:stdio \
> >     -m 2G -smp 2 \
> >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> >     -append "loglevel=3D7 console=3DttyS0" \
> >     -machine memory-backend=3Dpc.ram \
> >     -object memory-backend-file,id=3Dpc.ram,size=3D2G,mem-path=3D/tmp/p=
c.ram,share=3Don \
> >     -chardev socket,id=3Dcan0,path=3D/tmp/sock-can0 \
> >     -device vhost-user-can-pci,chardev=3Dcan0
> >
> >
> > Restarting the interface (i.e.: ip link set down and the up) does not
> > fix the situation.
> >
> > I'll try to do some more testing during the next days.
>
> After a deep dive, I _think_ the problem actually lies in vhost-device,
> since it is not there (or al least, it seems so) using an alternative
> implementation that uses the qemu socketcan support [0] (implementation
> which builds on top of the work done by Harald and Mikhail):
>
> qemu-system-x86_64 -serial mon:stdio \
>     -m 2G -smp 2 -enable-kvm \
>     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
>     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
>     -append "loglevel=3D7 console=3DttyS0" \
>     -object can-bus,id=3Dcanbus0 -object can-host-socketcan,id=3Dcanhost0=
,if=3Dvcan0,canbus=3Dcanbus0 \
>     -device virtio-can-pci,canbus=3Dcanbus0
>
> Unfortunately, my Rust knoweledge is not sufficient to understand the
> vhost-device implementation [1]; the issue seems to be related to the
> host->guest vring becoming empty and not refilling anymore.
>

Can you try with
https://github.com/MatiasVara/vhost-device/commits/fix-for-923/?

Thanks, Matias


