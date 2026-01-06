Return-Path: <linux-can+bounces-6012-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9551CFA8C9
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 20:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EBF631658A0
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369033A6E5;
	Tue,  6 Jan 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NC+JFZEs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHINULO+"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA3E27874F
	for <linux-can@vger.kernel.org>; Tue,  6 Jan 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723474; cv=none; b=TtbKnYb0EAXrI2C8wIfAz5hFHuGGS5OzvThWZryenfY8LxVAMnRlHOmq4cEYLMdz2Pe0EDC2lEFeX8jIA/cPF4fOjneVS0r6tE2LqbMRQwg2L2pEgIrug8ci5Ik/oglOcvPIuA5TgwRDPrPHjjhavU7R/UeWT3Mtu4yj6ryLm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723474; c=relaxed/simple;
	bh=hbVXGVUkpaJ36ieg+1Gp9BoxksljLrOy+6GnHSTFfV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0KjXEaV/kM/NK2ZymbL3aMpC85Sg/RqEs7EdZnHpcVNOEzExyqtZGfsNQQnUaY+vi6l3T+XuzZZh5sf9cP0B9aJHpCpm9y8KbPfRjvtSnmH/xv2VJsp8v1/xNi1pL7idQFKLRO8EOq8UuvZ70cTQmV8fXQK9imVkqPPZ787SzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NC+JFZEs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHINULO+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767723471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfVy8of3+aJW6NeuJLXPr8pnZKn/sYRSl6dFs62/nAA=;
	b=NC+JFZEsHmthhlPAWGGGFMAf09hFnxEpuylom5F3S9Pf1MI0VX63Qo4RddsK8fx2cP0XYH
	4khij9gGEiehq3JRuECrNBwVn0I7dc6OS9mhy/xvf5pBKZeSGrDro9PSd/E50HU+yxug3k
	f8vVlOCJSF1RG+CbBNnYig7f1Yq+Yy0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-MguUuN8wN_GNr4zxJUVLDg-1; Tue, 06 Jan 2026 13:17:50 -0500
X-MC-Unique: MguUuN8wN_GNr4zxJUVLDg-1
X-Mimecast-MFC-AGG-ID: MguUuN8wN_GNr4zxJUVLDg_1767723469
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8395cae8c8so146659666b.3
        for <linux-can@vger.kernel.org>; Tue, 06 Jan 2026 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767723469; x=1768328269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfVy8of3+aJW6NeuJLXPr8pnZKn/sYRSl6dFs62/nAA=;
        b=VHINULO+sG/F2BMRb3lNV4p/aB9NHA0k1oHoC/wHLgsXGn7Sc9nq/ioCtbLnvYM5cV
         EhinfAhO5V/VNmzAbYasi2FaNu1EQFVx1z/EJ/OhcYoQ4NjLb67WTqiI0C91zx7hhM1Q
         g5D2+PLJBGe9arD6GMmoZfwJDj4wsstVWJMT4wZa9QZB7s2wKe5I/AJ4Jd4UTFtMWBpw
         Nt3d3W8/LxbGHMG8JBuFp+rwHyiSVuT2OfXvyCeQy36FFHrOqEmo1qG7YIJzAUDm/FUR
         S/NQFdXX5JSUHAWr+QGxYDIJm8xZxOWEMrj1xGql2Pz806nqasRoPb4lfx+ntE9QEquv
         6BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767723469; x=1768328269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NfVy8of3+aJW6NeuJLXPr8pnZKn/sYRSl6dFs62/nAA=;
        b=ptPqUC96aKOPv92WlpIYJyWz953x5cWYS/0aEPea0QanM2vPu9E3ei1ZhLLbYAoUSm
         tvV+hJ3KrDh1tjtWmMbWD8+IXk5c1KxooXUuY0M+zNsfwlE3eqUWltPXrRbVxX+CpgKm
         yhjlUYmT/v7K4dddguDvqcLLuZqTDS5AfKPr6Vy5wTmYv4hhxXTg3UBq0qEmkhZ2IEfd
         SuC2hl1dA7bhiWxsb6/z+tPBmfxPTIhjlHbjaksF1XrTk+MojohLCu+k8U8CGQeyiFzt
         f7xG9vQbfNYAfgjF+IdimxttCXiUnmhZrv4sbp2zBEf56ojjqYBtr+beVVJeETEx5Z4M
         IGLA==
X-Forwarded-Encrypted: i=1; AJvYcCUSwSHccn2NsG1cNv5/AGsGFf6oKiFf80bwYy+0UuSdvAjPAdK8q7GGAcqPlDUb+52io4I7kTSegxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9XRGpj4tZaTcT7teK5l9mmfiPq3V1I2JZrI2sba/6ZnUkems
	jIcfT8OEdzz2zF6Gx03qUQ4z5t6UusifINtUkvaU6Enl0eV9iiPm1fSJVyt7/XpZNfROq6CX83R
	Myfy8cUyEwwOstC3mQqVQFLXJFWFjF1GE7+W1fcJVP0x6a3mpePj+6rGmm2z/guE5XA0j8v8s48
	SSxFlgau34K5GZEhSOSq4TjXcUVi1X5DbBIpW4
X-Gm-Gg: AY/fxX7qXFJA1xFW+Huwm9CLqqi4TP/carxhuH/X5n4jNgDW+u/vFBXdua8V8yi4YVJ
	HWHkjfGEpIRw+f3q+s1Ty1M5sWgsPiWMlLqUDIKQcEDyl0EO/LiqGO5n0ScpEU063flUc7fiHpC
	50b0e5U5dpjQOJhXgvMTeh7W7SqMAkoB2InY3CRRYfcUbrsPsNR5IjBsy05umLV/b9c9nnDI6kE
	QnhwvDPiWejIBMTZgTelan0
X-Received: by 2002:a17:907:1c09:b0:b80:402f:569e with SMTP id a640c23a62f3a-b8444f3b2c0mr7684166b.25.1767723469231;
        Tue, 06 Jan 2026 10:17:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbW+DIj65TyFKYfPGXJs0UUucWEQ4iwiu139bnv8qw7NBLAUOB2v79PYba6VDsXnm+Y7t5P+yjtPw4ydyHEZQ=
X-Received: by 2002:a17:907:1c09:b0:b80:402f:569e with SMTP id
 a640c23a62f3a-b8444f3b2c0mr7681466b.25.1767723468813; Tue, 06 Jan 2026
 10:17:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater> <aVLOPMmpvArnVAHZ@fedora>
 <aVLq1ibPcPHk-7Qv@bywater> <aVWQ0laxIdp3fx+p@fedora>
In-Reply-To: <aVWQ0laxIdp3fx+p@fedora>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Tue, 6 Jan 2026 19:17:37 +0100
X-Gm-Features: AQt7F2r9-ci3DQUZfnLTBt5oJltITOVEcZKMD_u9FzKGObMxxXgIW9lPtyc0X0Q
Message-ID: <CAHYGQ0yVCgguwnLLYBCFrtEuNMErNaB5Fye5HG_KoZgusixh3Q@mail.gmail.com>
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

On Wed, Dec 31, 2025 at 10:08=E2=80=AFPM Matias Ezequiel Vara Larsen
<mvaralar@redhat.com> wrote:
>
> On Mon, Dec 29, 2025 at 09:55:50PM +0100, Francesco Valla wrote:
> > Hi Matias,
> >
> > On Mon, Dec 29, 2025 at 07:53:48PM +0100, Matias Ezequiel Vara Larsen w=
rote:
> > > > While stress testing this, I noticed that flooding the virtio-can
> > > > interface with packets leads to an hang of the interface itself.
> > > > I am seeing this issuing, at host side:
> > > >
> > > >   while true; do cansend can0 123#00; done
> > > >
> > > > with:
> > > >
> > > >  - QEMU: the tip of the master branch plus [2]
> > > >  - vhost-device: the tip of the main branch
> > > >
> > > > and the following QEMU invocation:
> > > >
> > > > qemu-system-x86_64 -serial mon:stdio \
> > > >     -m 2G -smp 2 \
> > > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > > >     -append "loglevel=3D7 console=3DttyS0" \
> > > >     -machine memory-backend=3Dpc.ram \
> > > >     -object memory-backend-file,id=3Dpc.ram,size=3D2G,mem-path=3D/t=
mp/pc.ram,share=3Don \
> > > >     -chardev socket,id=3Dcan0,path=3D/tmp/sock-can0 \
> > > >     -device vhost-user-can-pci,chardev=3Dcan0
> > > >
> > > >
> > > > Restarting the interface (i.e.: ip link set down and the up) does n=
ot
> > > > fix the situation.
> > > >
> > > > I'll try to do some more testing during the next days.
> > >
> > > I tried this and I could not reproduce it. [2] requires a minimal cha=
nge
> > > to apply, i.e., qdev-properties.h has changed to /core. I'll send a v=
2
> > > for that. I used latest vhost-device-can. I run `candump can0` in the
> > > guest and `while true; do cangen vcan0; done` in the host. Am I missi=
ng
> > > something?
> >
> > With the plain 'cangen' you are not really flooding the interface, sinc=
e
> > you are only sending a random CAN frame every 200ms. The only way I can
> > reproduce this behaviour in a consistent manner is running from the hos=
t:
> >
> >     while true; do cansend vcan0 134#00; done
> >
> > which seems to generate the maximum amount of traffic.
> >
> You were right. I could reproduce it. After a while, I stop to get packet=
s
> in the guest. I'll investigate.
>

I think I found the problem and it is in the device. When the driver
adds descriptors in the rx queue, It seems the device is collecting
all descriptors from the rx queue and trying to consume them in one
run. However, in some situations, there are not enough msgs to write
in a descriptor and the device returns but the descriptor is never
consumed and the driver does not provide a new one. I can see that the
host continues to send msgs to the device but the number of
descriptors in the rx queue continues to be 0. I am trying to figure
out how to fix it.

Matias


