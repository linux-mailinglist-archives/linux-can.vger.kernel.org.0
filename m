Return-Path: <linux-can+bounces-361-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1287389B
	for <lists+linux-can@lfdr.de>; Wed,  6 Mar 2024 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45351F26447
	for <lists+linux-can@lfdr.de>; Wed,  6 Mar 2024 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146E412FB0F;
	Wed,  6 Mar 2024 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIS3xdqb"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7B130E49
	for <linux-can@vger.kernel.org>; Wed,  6 Mar 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734345; cv=none; b=SGW+etijdwPyJa0JHASb2V82tn/hifhoKua4KUFRUYET4kqSYTW7Rl2kHsKIDQLimx3sp8HEV4wK8oBVk2xrLYxMok6u951GHpj5IxqzM47NPgutjGHlOb2ffVStM2PiqGSJwTdlUuRMDcsOEeVcRGEytxRQnIM4DvucapNvyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734345; c=relaxed/simple;
	bh=4zwg3NbpDWTlT1vvo2kz+bbQUuJMRzBClGhARdtYs6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEAXJqwHW/abqF1GY7lDpuZs7xBsXMhb0w17k0ZggdD1c5SQiKiHmFd08C/1rPNewp4Bfz5URTOD506P+Zw49c7RI3IRCpvOcWB4hmOJCQi1oOC8UwjBYA9YDEezGMuTM9/Aqztc3KJI5/AGalgnncag3Sy4bH3+XIfNxnxcQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIS3xdqb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709734341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nux+gy8oe78A20fCqODs/Roehud0Eqe+c8e2qYVUsZk=;
	b=jIS3xdqbK2Mivnq76xvhiVqXThs8ikip/kbqtdlcWa+dAiywC8XyDeHAL5zts+CrBHl6KV
	4Jev0DX3MuqO587DKZiUi15n3Q+BFPnabOq67iE3Z3rS7NKM+xoyB4U6tiU8dC486VoWrA
	7DRc1t17OCegMo9DpMLqZwzchmKRS/E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-m4OnmJMOMG2Z-ujRpOMibg-1; Wed, 06 Mar 2024 09:12:20 -0500
X-MC-Unique: m4OnmJMOMG2Z-ujRpOMibg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7876f29a8daso1002559685a.3
        for <linux-can@vger.kernel.org>; Wed, 06 Mar 2024 06:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709734340; x=1710339140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nux+gy8oe78A20fCqODs/Roehud0Eqe+c8e2qYVUsZk=;
        b=OzB80ntmjBMnYhRbRX5U026dRFHm8JWpBwnPm5KRZqGDp+e5lYo2U5mbiL/GMIZ/ac
         8xF3o66cankLHxo0v7TQ8HolyX092jUNACgtRRPRZTsAjHyoA06z9U/WxLdVgJ+pWdEs
         pEEtiM6URTizPxfFXDyz8mMJlnh+KxCU5jUgd8VrGNEr7+STSqsIlwCNq2ab5CtZ75kG
         2AvvYLPnxj7V0bPZsigviHNy2arWRSRJ8vzdhD+bgqWDioVKq047x5SnebvC8fbJTS1K
         IBmIFU/6E3pgtvZ043mGz+xWmgGiPmfhtHORWDyBjq08d7NON1CzgbJ0/F4awQqREDWm
         2ZpA==
X-Forwarded-Encrypted: i=1; AJvYcCXYxNrtlocBwLImcsB1uJS4BJpJ6alkMK1YMQWx2HdLbrZCr8Q5GEyKOtjuroRsPTvaRdDRW9u6rIWtmJzIDxKPYbYI685B3sC5
X-Gm-Message-State: AOJu0YzpRjHxiJ4QgUA1uqkuwmohgh9MwuToFyghCnHZ6Qckv7mqkQ2i
	f24O9bxcjvJz58xQCX9V3mkGzUOHiJpgtQmf0UUER03z2Sb0DjMd+vlR+BTDIVddO4r6QxW4kMr
	Ge3nPz/tZTfHKRq4NkaAkixt2Ae5W4RRYCqDvsEJhc6In54ndthZfFol7Wa4ke3t4jw==
X-Received: by 2002:ae9:e903:0:b0:788:32c4:7d05 with SMTP id x3-20020ae9e903000000b0078832c47d05mr6003950qkf.17.1709734339912;
        Wed, 06 Mar 2024 06:12:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnAQDTJjbcHI9br7vQp8C1bR9pF3b3WaTUXY0nAVPSWnqoOLZmWBhDJG6ltUMIPaBAFEZJeg==
X-Received: by 2002:ae9:e903:0:b0:788:32c4:7d05 with SMTP id x3-20020ae9e903000000b0078832c47d05mr6003926qkf.17.1709734339550;
        Wed, 06 Mar 2024 06:12:19 -0800 (PST)
Received: from fedora (101-135-12-85.ripe.phibee-telecom.net. [85.12.135.101])
        by smtp.gmail.com with ESMTPSA id w11-20020a05620a094b00b0078821ef8162sm3914552qkw.9.2024.03.06.06.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:12:19 -0800 (PST)
Date: Wed, 6 Mar 2024 15:12:15 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	linux-can@vger.kernel.org,
	Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.
Message-ID: <Zeh5vyfiI33sSVVo@fedora>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>

On Mon, Jan 08, 2024 at 06:18:50PM +0100, Mikhail Golubev-Ciuchea wrote:
> Hi all!
> 
> I kindly request a vote.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/186
> 
> 
> Best wishes,
> Mikhail Golubev-Ciuchea
> 
> 
> 
> On 6/9/23 16:22, Mikhail Golubev-Ciuchea wrote:
> > From: Harald Mommer <harald.mommer@opensynergy.com>
> > 
> > virtio-can is a virtual CAN device. It provides a way to give access to
> > a CAN controller from a driver guest. The device is aimed to be used by
> > driver guests running a HLOS as well as by driver guests running a
> > typical RTOS as used in controller environments.
> > 
> > Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> > Signed-off-by: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
> > ---
> > 
> > RFC v3:
> > * Add length fields in CAN RX and TX messages.
> > * Replace bus off indication queue with a config space bit.
> > * Clarify handling of unknown flag bits set in CAN frame.
> > * Remove MISRA C suffixes in constants.
> > * Reserve 16 bits in RX/TX messages for CAN XL priority.
> > * Reserve 8 bits in RX/TX messages for CAN classic DLC.
> > * Rework according to general virtio spec POV.
> > * Implementation:
> >    driver: https://lore.kernel.org/all/20230607145613.133203-1-Mikhail.Golubev-Ciuchea@opensynergy.com/
> >    QEmu device: https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3
> > 
> > RFC v2:
> > * Add CAN classic feature flag.
> > * Add feature flag VIRTIO_CAN_F_LATE_TX_ACK.
> > * Add feature flag VIRTIO_CAN_F_RTR_FRAMES.
> > * Reserve 32 bits in RX/TX messages.
> > * Remove priorities of messages.
> > 
> >   conformance.tex                         |  12 +-
> >   content.tex                             |   1 +
> >   device-types/can/description.tex        | 249 ++++++++++++++++++++++++
> >   device-types/can/device-conformance.tex |   8 +
> >   device-types/can/driver-conformance.tex |   7 +
> >   introduction.tex                        |   2 +
> >   6 files changed, 275 insertions(+), 4 deletions(-)
> >   create mode 100644 device-types/can/description.tex
> >   create mode 100644 device-types/can/device-conformance.tex
> >   create mode 100644 device-types/can/driver-conformance.tex
> > 
> > diff --git a/conformance.tex b/conformance.tex
> > index 01ccd69..a07ef02 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >   \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
> >   \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
> >   \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
> > -\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
> > -\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
> > +\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
> > +\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
> > +\ref{sec:Conformance / Driver Conformance / CAN Driver Conformance}.
> >       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
> >     \end{itemize}
> > @@ -59,8 +60,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >   \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
> >   \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
> >   \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
> > -\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
> > -\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
> > +\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
> > +\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
> > +\ref{sec:Conformance / Device Conformance / CAN Device Conformance}.
> >       \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
> >     \end{itemize}
> > @@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >   \input{device-types/scmi/driver-conformance.tex}
> >   \input{device-types/gpio/driver-conformance.tex}
> >   \input{device-types/pmem/driver-conformance.tex}
> > +\input{device-types/can/driver-conformance.tex}
> >   \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
> > @@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >   \input{device-types/scmi/device-conformance.tex}
> >   \input{device-types/gpio/device-conformance.tex}
> >   \input{device-types/pmem/device-conformance.tex}
> > +\input{device-types/can/device-conformance.tex}
> >   \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
> >   A conformant implementation MUST be either transitional or
> > diff --git a/content.tex b/content.tex
> > index d2ab9eb..8806b57 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -765,6 +765,7 @@ \chapter{Device Types}\label{sec:Device Types}
> >   \input{device-types/scmi/description.tex}
> >   \input{device-types/gpio/description.tex}
> >   \input{device-types/pmem/description.tex}
> > +\input{device-types/can/description.tex}
> >   \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> > diff --git a/device-types/can/description.tex b/device-types/can/description.tex
> > new file mode 100644
> > index 0000000..2511d9c
> > --- /dev/null
> > +++ b/device-types/can/description.tex
> > @@ -0,0 +1,249 @@
> > +\section{CAN Device}\label{sec:Device Types / CAN Device}
> > +
> > +virtio-can is a virtio based CAN (Controller Area Network) controller.
> > +It is used to give a virtual machine access to a CAN bus. The CAN bus
> > +might either be a physical CAN bus or a virtual CAN bus between virtual
> > +machines or a combination of both.
> > +
> > +\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
> > +
> > +36
> > +
> > +\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues}
> > +
> > +\begin{description}
> > +\item[0] Txq
> > +\item[1] Rxq
> > +\item[2] Controlq
> > +\end{description}
> > +
> > +The \field{Txq} is used to send CAN packets to the CAN bus.
> > +
> > +The \field{Rxq} is used to receive CAN packets from the CAN bus.
> > +
> > +The \field{Controlq} is used to control the state of the CAN controller.
> > +
> > +\subsection{Feature bits}{Device Types / CAN Device / Feature bits}
> > +
> > +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
> > +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
> > +CAN~2.0B Extended CAN IDs is considered as mandatory for this
> > +specification.
> > +
> > +\begin{description}
> > +
> > +\item[VIRTIO_CAN_F_CAN_CLASSIC (0)]
> > +
> > +The device supports classic CAN frames with a maximum payload size of 8
> > +bytes.
> > +
> > +\item[VIRTIO_CAN_F_CAN_FD (1)]
> > +
> > +The device supports CAN FD frames with a maximum payload size of 64
> > +bytes.
> > +
> > +\item[VIRTIO_CAN_F_RTR_FRAMES (2)]
> > +
> > +The device supports RTR (remote transmission request) frames. RTR frames
> > +are only supported with classic CAN.
> > +
> > +\item[VIRTIO_CAN_F_LATE_TX_ACK (3)]
> > +
> > +The virtio CAN device marks transmission requests from the \field{Txq}
> > +as used after the CAN message has been transmitted on the CAN bus. If
> > +this feature bit has not been negotiated, the device is allowed to mark
> > +transmission requests already as used when the CAN message has been
> > +scheduled for transmission but might not yet have been transmitted on
> > +the CAN bus.
> > +

I think this description should be split it into two: 
1. The description of the feature.
2. How the behavior of the device changes whether the feature has been negotiated or not.

2) is already described in the device operation by using MAY and MUST. I
would rewrite 1) as "the device supports delayed used notification ..."
or something like that. What do you think?

Matias


