Return-Path: <linux-can+bounces-6022-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8979BCFEDA4
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 17:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB34305EE51
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 16:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3DF369234;
	Wed,  7 Jan 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bu4QAHOU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlWty0Pg"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E03557F2
	for <linux-can@vger.kernel.org>; Wed,  7 Jan 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801700; cv=none; b=gkE/qllkkYSWbw4EMu+f/yKynLbmBd/vmEqosyC5MeD+0lkqSL8SvUmPH/+ZLwTgiMCaK8BgfBeEeCgANbGfxMLwtauX7ifwGQzlzzkLC4lyLn6/4tVdPZrWPtxjrgv8pX3opggA2es8eqmuCCKVikfuJF3vtIZGTE2Qi4MMNQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801700; c=relaxed/simple;
	bh=MdOcdyzquYrZDcCkvAdD4u7MwXhRoEn3mysqAcqq4vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psJYSPcfizOYWFmSjBeqd6khYCVbhnFeilmKmD18m8NZF1x0ImsaoPtc/FHZiXM0ngXKLRW0WfVGOYGPM67faN0nh2IrDdCGk1cl9ssWQtgYEdlgoXobVcrWX9X3RQjQRaIq89hAHEvZTe4k87zqAZxwuo9rlBwyT2a+xhF2DYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bu4QAHOU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlWty0Pg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767801682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GCGBIzPMtbCjCRcA/11dyPDvN/EIpJyJO7gZQLRTXU=;
	b=Bu4QAHOUuemt7HUbZN4ts4FqPV62hrZomoxPYk2u8QuoJkC52dRyWQlF35CnaPgZtZ+TMr
	FI3EMBP2AozajQkVCLD1UHTLVT2hOnfXwoY2RgJP4x/eUgHEBzZaYy/EN1r05DkgKx+1ns
	GaaHClfb8JOpFVndC2Dbt+1BwAOO0cw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ENkJqSF5NiakTiqJg97a4A-1; Wed, 07 Jan 2026 11:01:20 -0500
X-MC-Unique: ENkJqSF5NiakTiqJg97a4A-1
X-Mimecast-MFC-AGG-ID: ENkJqSF5NiakTiqJg97a4A_1767801679
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b802d6ed5b0so269407466b.1
        for <linux-can@vger.kernel.org>; Wed, 07 Jan 2026 08:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767801678; x=1768406478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GCGBIzPMtbCjCRcA/11dyPDvN/EIpJyJO7gZQLRTXU=;
        b=QlWty0PgrHqY8K/ARbLfQil8a8JOKQFu2ICBOPbTi3FzwSnCPj9dGt7kJyfK2HE0jo
         kionPTbdtVPoXGtdHc0OtcY5bNQG6+vnWHhnFQx10eWwgzi8OZKJ+PrGjeGy52X2KyrH
         4lhcybW1CW+OV+Aj+lgpnxcd4VcAKEw9G2MzdBFIu3ehSzQX1WnezeHUbNGf0OOL4rnD
         xeBRRPV0ZoiloJgJTWd4PLrTaI8H3G/pHapke6lQZwBjwsNdFUIvsfwMt26Q2TuOGdkf
         CxAqmXon7PDaGUyDY9mPxoIvjjxr0CDs0ylhuTM0YI4PC7U+H7AXzhs56LMDPjNKodYw
         vcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767801678; x=1768406478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GCGBIzPMtbCjCRcA/11dyPDvN/EIpJyJO7gZQLRTXU=;
        b=UFqKILH/iwDG+4nOc9uvN4W+ARc2bj3XT1V77BhUk9EeGudjeQyCcxe/q+W+yrMHOO
         2wFVJF9FWsZPe2dmxWUibLFxSzzbazx1oNqrbxVFRk1+/oIkGZNbmKs+WMdZ+DxvXPjd
         ZLywhqfTwrfngqGhbe9t77uTtZCaZmk3lv5kaCjLsn5KQLo5TulsbcBtc8Cc9OMlIwV+
         eXDKLMC26lMboK53cqOBJniDjFlNc+5hUvJYw6kjyOWuKzvbTXlsUPtFRIP75PUt43Ru
         qDtUVWAjxwAQG3imU6557WttVR5BOrHeGfeCnlHYZ5SwiMUcLilX2aAGLPG214XIZjMY
         LQUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZKLziCA1k7lmSXxuKKy0qUDN0ZYFwnkEIlRGhuhoWQicH4IEEuMIxqnp/mhDC7b1avODRJ6tOEQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDiPKypPZFNmLOHrkNEnR+s8Zc6fRE8BuwIW5ypGfkbrDvglhf
	wdOhPx/MQDA5iv94xmC5dylUl3WKXCx083rS8uUi+vqgM/Av8bizFxmfN68WIiOl1PDHfqEtRrs
	WIsQzIr0mFSwOKH8PI4MQME+Npm2y6KbfadAsWCTjUJUOgqDUb4dVKV2z67ZDu08N13wic8Kw3N
	JvNs6/kIHdSxmUM/bPPDAyml6gTFDjUsgV0r38
X-Gm-Gg: AY/fxX5IIy1DFnNkEEUYUcJREAy7OLBuQ/MiyQV4/mwIqrZY/O8wr46iV5i9+cejAtf
	Pk1hfUVM9KJ5yt6IQkYlmMi7ctbS6B0uGoIP03eZqssWsa5O/xkHx55IXTXcdgkjgw38ZBJziMB
	rrpToh+xGWgop0oXDKXiRVIwynXZU449oShdnuS1S2dunj3pT5CC3iS+VH5TAgJ+kGOnqlXvlIT
	VJCKyUTCCH4O3VNQWSouKGj
X-Received: by 2002:a17:907:744:b0:b3a:8070:e269 with SMTP id a640c23a62f3a-b8444cdaca3mr324248666b.14.1767801676936;
        Wed, 07 Jan 2026 08:01:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyCAq53fyeByL4uwfhi/No4YQ7czygIKiwAQVVyDJqhoFue0IDP5c7aLvHfVLZvRrOyLo5oxdZcQ/tUxmoZNg=
X-Received: by 2002:a17:907:744:b0:b3a:8070:e269 with SMTP id
 a640c23a62f3a-b8444cdaca3mr324238066b.14.1767801675603; Wed, 07 Jan 2026
 08:01:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater> <aVLOPMmpvArnVAHZ@fedora>
 <aVLq1ibPcPHk-7Qv@bywater> <e5bc1353-ed3e-478b-a26e-0bb9a50b3863@oss.qualcomm.com>
 <4cf222cb-e6e3-4d09-a7d8-bc64b8e148bd@hartkopp.net> <aV1zB_fYQE_OBZm2@bywater>
 <8134fcf0-9a9d-41be-bcc3-80db23932f9b@hartkopp.net>
In-Reply-To: <8134fcf0-9a9d-41be-bcc3-80db23932f9b@hartkopp.net>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Wed, 7 Jan 2026 17:01:04 +0100
X-Gm-Features: AQt7F2rsYl9GEMuxAghLtvGU8Co9nXZ_2-3hri17K1baiVrKZlfsg5jLK74bXDM
Message-ID: <CAHYGQ0yTNTf3T=FM7B3NcG_BFmUSDS62cO0s=x2Bb7U1j=bq5A@mail.gmail.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Francesco Valla <francesco@valla.it>, Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org, 
	virtualization@lists.linux.dev, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:45=E2=80=AFPM Oliver Hartkopp <socketcan@hartkopp.=
net> wrote:
>
> Hi Francesco,
>
> On 06.01.26 21:39, Francesco Valla wrote:
> > Hello Harald, Oliver,
> >
> > On Tue, Jan 06, 2026 at 08:43:42PM +0100, Oliver Hartkopp wrote:
> >>
> >>
> >> On 06.01.26 17:50, Harald Mommer wrote:
> >>>> With the plain 'cangen' you are not really flooding the interface, s=
ince
> >>>> you are only sending a random CAN frame every 200ms. The only way I =
can
> >>>> reproduce this behaviour in a consistent manner is running from the =
host:
> >>>>
> >>>>       while true; do cansend vcan0 134#00; done
> >>>>
> >>>> which seems to generate the maximum amount of traffic.
> >>>>
> >>>> This is not of course a realistic bus load, but is leading the syste=
m
> >>>> (at least on my setup) to a corner case somewhere.
> >>>
> >>> I have no idea how long the shell needs for a loop, always used cange=
n -g 0 to stress the setup which is most probably faster than the shell int=
erpreter, and sometimes did this for both directions (RX and TX).
> >>>
> >>> Full load is a realistic setup. And even if it was not, if something =
stopped working or worse crashes torturing the setup this was a problem.
> >>>
> >>
> >> Yes. cangen -g 0 -i <interface> creates full load - even on real CAN
> >> interfaces. You can also generate fixed content if you want to omit th=
e
> >> generation of randomized content. 'cangen -?' prints a help text.
> >>
> >
> > I agree with both of you - I was simply arguing that a plain 'cangen'
> > with no parameters is not really loading the interface.
> >
> > For some reason, I was only able to trigger the unwanted behavior with
> > cansend in a while loop and not with cangen -g 0, even with fixed ID an=
d
> > payload. However, I suspect the issue is a matter of timing and
> > coincidences rather than load level.
>
> Yes, the difference is, that you open a new CAN socket each time with
> cansend, while cangen opens one socket and pushes lots of frames into it.
>
> Btw. this should not lead to a stuck CAN interface.
>
> Is the interface usable from another terminal (with cansend/candump) or
> how does this 'stuck interface' look like?
>

I reported the issue here:
https://github.com/rust-vmm/vhost-device/issues/923. It seems it is
the device implementation. I am working on a fix.

Matias


