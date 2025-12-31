Return-Path: <linux-can+bounces-5976-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A212CEC8ED
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 22:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1947C300ACD3
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 21:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DAC242D72;
	Wed, 31 Dec 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUlLBMmM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pg8nOAOG"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5122F5337
	for <linux-can@vger.kernel.org>; Wed, 31 Dec 2025 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767215333; cv=none; b=vEtqLFr7E9qFCLKvoHFsVlZ6722cj4nyHDs41HFQni12eDxWtYTSf8JfqEd9wKDuw6A1VEUZi3AAeIvWizZyUGgvWkMrPOUEvpocGOay06UvjUywZll79NwDPJpeHIf1z/SjnElREGYcvmuhEM1saX/4U9JwhV7w8rQjDE/V7X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767215333; c=relaxed/simple;
	bh=NEavsbS+MYgvZbyUEA0n5b+NpFHMUAVVeVoqvcJ/Xe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRI+fFI1ymA7yK5jueorkgXpmezJgk5dpIsnqNTxxSSD3nD/W6/2kzA0biHgEZNYd9h8xYeiS777JQTOTsGy0VBdXDr26HGxROt/EPzymhfXZLEg1e8K50boFwFlQ0Rr0/DYtgTPmWiBW/w046eotasBv590GY4ydIp69avbwPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUlLBMmM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pg8nOAOG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767215330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=607vL4Qm5Hi1Y96elBHDWEflyHPmZnMU1mQjlKs0Qjg=;
	b=iUlLBMmMfUz+MG6ivfOR44y++Aqf5d0bio+cSflraU1iMUkjtyX25IDaUd5qq3c7MzGSw0
	40G3yFz+0bzgWI+9k5vBzLiHaNhElpL29f+sjL8WC2HEj5LuCM8EADcO44VIWdfoSAOV5l
	Sz/FKheJ62ZdG1ijXqP41JckwkmPKLI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-__7jvXwqNeibmeWEotzPJw-1; Wed, 31 Dec 2025 16:08:49 -0500
X-MC-Unique: __7jvXwqNeibmeWEotzPJw-1
X-Mimecast-MFC-AGG-ID: __7jvXwqNeibmeWEotzPJw_1767215328
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4325ddc5babso4418600f8f.0
        for <linux-can@vger.kernel.org>; Wed, 31 Dec 2025 13:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767215328; x=1767820128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=607vL4Qm5Hi1Y96elBHDWEflyHPmZnMU1mQjlKs0Qjg=;
        b=pg8nOAOG45SoEgIropvS7JHCn9ANL+WcZoxi0c36LVbLLZM2u/4wz/UpfZJmiGqayD
         3aBHnaGcjLW7DUFWipXpzBdMqR6bYr7Hs13qm8ktOTxw1ihQ/GjhGO201l3YxGysmm6Q
         TKM1w7JDa+iZLmLV0PrXGsWOXJv0R8SIWd25s1OAVjqqwmdtukDHc+aDQ+5+2ECauaHh
         jQjq8RHQuIO0tLkgS8f5kae8wxHulKBjSnwD2CRHK6Pre7cAgs4BVDtlSDEA1SMJTSfn
         czCABSJ9Am7e7x5Pygc7Xm1UYV46exAXYypLLngWnC5fBM1IROpjTqxDitZMZETp9Fhv
         eDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767215328; x=1767820128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=607vL4Qm5Hi1Y96elBHDWEflyHPmZnMU1mQjlKs0Qjg=;
        b=JLkOrsRnyvRqVujdLNSkzYOX6RnWAYnC8YoCmQ/NtT5nAvnyPlwsIj1zwcsltt6Ft5
         /WeABGv5UsnFzqAjOs++s84sR3irZrvBwEhQxbJNv87PqY0NB+AyMo6jnADkEYJ3U/OS
         umal+uJlt+W+iYWz0yDNsi456u4W7/giSFHOiWUFSHZ9RAeCf3YZ+faG99CDxvpxQBxX
         Xekc2Qz8yZusQny3opUM15S6posfbKJgqyOjBn9zCqWEGc3hFN2mbMJmO6Ix8F1Ab12s
         KzfAxV11XuwEJjzGP+Vg5HICT/lwGs4Kqi0vau/nLZ9dA/3Q7qYUVnQRun/XDnvkWORA
         8taQ==
X-Forwarded-Encrypted: i=1; AJvYcCW75dFNgUgCprPBkXo8WQwRyjSzF+YAmoQodNsSscFnICIfTg0cAPRzbaFCjvMoO5YQA/gv2J7G6Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwN12j9ZTW2IF76HtU21VUNuOr84oXvdHu2Ca0g7NZm+4ugIgO
	jDlVvE0wssvnQC9svG8okRMkrFGRRIFrCwUgyzVWxa/N5Y1f5Jk/9Ef7/HvNrm1G1+TnKdU0VhJ
	p0ZnFBxrXwdT6Y+l24Oe/hEGiWCSDfWvcU1om805sMTjDvMhL6A/Id2wk0PX78Q==
X-Gm-Gg: AY/fxX5qQH5Bn0UfQYXxbuMHNHanuH1Mwc9t/MIbtmdlwV0gKWmcLk8BBkyoNxefLEi
	4f4JACDYR/WQUeqef5r9pDK9/PJgVFdrz5fMV2ymlBYjLZM2ureeKh3ZLVSofTirUrtH7GEPaAO
	XqSpqskIpKgSJ/LWdMV/NGeZX9DnH+WtTQPVO87A1/aSMVRBBjxEOB8FaDSAT5cnL7iVSFMm2A3
	aSmPgfvHYl5D7xWwjw6G/O3bGVqkBMLk+aTScnip0DVgc8q3RkZJdSHQjpR3QJteJo/k9I4Tfm4
	9mFebKEZvcvMdM8ctA/8FgSB4Ept3DI9QoKfLv8AiUvcTJgj3LFoJhB62yDjARMbKWW816RYpAo
	=
X-Received: by 2002:a05:6000:178a:b0:431:c2:c636 with SMTP id ffacd0b85a97d-4324e4ccf5cmr53000699f8f.24.1767215328071;
        Wed, 31 Dec 2025 13:08:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjZGHdmylBd9EpV00RHddE+SBBivtlR/NvaDmcBP16RKKvt2R5hlqHedlqvszkmMez70DHew==
X-Received: by 2002:a05:6000:178a:b0:431:c2:c636 with SMTP id ffacd0b85a97d-4324e4ccf5cmr53000668f8f.24.1767215327679;
        Wed, 31 Dec 2025 13:08:47 -0800 (PST)
Received: from fedora ([37.168.2.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227casm75349141f8f.15.2025.12.31.13.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 13:08:47 -0800 (PST)
Date: Wed, 31 Dec 2025 22:08:34 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
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
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aVWQ0laxIdp3fx+p@fedora>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aVLOPMmpvArnVAHZ@fedora>
 <aVLq1ibPcPHk-7Qv@bywater>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVLq1ibPcPHk-7Qv@bywater>

On Mon, Dec 29, 2025 at 09:55:50PM +0100, Francesco Valla wrote:
> Hi Matias,
> 
> On Mon, Dec 29, 2025 at 07:53:48PM +0100, Matias Ezequiel Vara Larsen wrote:
> > > While stress testing this, I noticed that flooding the virtio-can
> > > interface with packets leads to an hang of the interface itself.
> > > I am seeing this issuing, at host side:
> > > 
> > > 	while true; do cansend can0 123#00; done
> > > 
> > > with:
> > > 
> > >  - QEMU: the tip of the master branch plus [2]
> > >  - vhost-device: the tip of the main branch
> > > 
> > > and the following QEMU invocation:
> > > 
> > > qemu-system-x86_64 -serial mon:stdio \
> > >     -m 2G -smp 2 \
> > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > >     -append "loglevel=7 console=ttyS0" \
> > >     -machine memory-backend=pc.ram \
> > >     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
> > >     -chardev socket,id=can0,path=/tmp/sock-can0 \
> > >     -device vhost-user-can-pci,chardev=can0
> > > 
> > > 
> > > Restarting the interface (i.e.: ip link set down and the up) does not
> > > fix the situation.
> > > 
> > > I'll try to do some more testing during the next days.
> > 
> > I tried this and I could not reproduce it. [2] requires a minimal change
> > to apply, i.e., qdev-properties.h has changed to /core. I'll send a v2
> > for that. I used latest vhost-device-can. I run `candump can0` in the
> > guest and `while true; do cangen vcan0; done` in the host. Am I missing
> > something?
> 
> With the plain 'cangen' you are not really flooding the interface, since
> you are only sending a random CAN frame every 200ms. The only way I can
> reproduce this behaviour in a consistent manner is running from the host:
> 
>     while true; do cansend vcan0 134#00; done
> 
> which seems to generate the maximum amount of traffic.
> 
You were right. I could reproduce it. After a while, I stop to get packets
in the guest. I'll investigate.

Thanks. 


