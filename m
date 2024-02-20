Return-Path: <linux-can+bounces-333-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F485BBC7
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 13:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C36D1F2221F
	for <lists+linux-can@lfdr.de>; Tue, 20 Feb 2024 12:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFF467E65;
	Tue, 20 Feb 2024 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKTCInMy"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136465BCD
	for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431550; cv=none; b=X9sz+7Pq2YwQnkJCruMu2Kptoi6HSdKF5/qYK3JNxTnyQ33W5fl4HEvJi3Lx5LRS8i6T41FE08DDDdyEEigo25RrWb2ixwPbO3h4inyqMEleejtXriBG34/ZgX4VBI0o7ladORagmqNfVGmzS9A6x2/nu8xwoxjGgs3aWdRrHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431550; c=relaxed/simple;
	bh=GT42VzuSYhnC2rO679bRzU1HkRjB2m1z8HrpK5v+Za8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZlYazrXfpJErMscvUInllfV5kmaHg9bb02QjjsJaJiCASw64pWKhaIAMLJExJdnqsMcs4+2+XTEldOkxUYlGRKptrX7rRquoe1m2c8YgHE56R9wpqMEEAfLSwYBo6Dj+Nub70cnp4FoHe+ppM4F9sCbUV+1TY+c5fSq/k33A6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKTCInMy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708431546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PSvKlxYTJ1WGbSz33qbmvPeGwoubasafQ6TRCDUandk=;
	b=CKTCInMy1UlKusG9K2GZe+A12iL1F77dCa93rj4Q1Ute2l2YdpoJFfu7TWLxhax8WPf7ee
	pbvr/hWpv3Fn0JbGFOFmw1/Eyw+xx2mp5fqQGVuojhRPKVNVd4XNcnuc9tpJK/vc+hNBSu
	cxhRM3vtUF7mGcU+8MZMSAyu1D7c8Xc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-dHf6Yj5uNpiGEoKXGIYHkw-1; Tue, 20 Feb 2024 07:19:04 -0500
X-MC-Unique: dHf6Yj5uNpiGEoKXGIYHkw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6800aa45af1so72259446d6.3
        for <linux-can@vger.kernel.org>; Tue, 20 Feb 2024 04:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431544; x=1709036344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSvKlxYTJ1WGbSz33qbmvPeGwoubasafQ6TRCDUandk=;
        b=Ces4Xje2idgCw1MiZ2HOFx6vnhjfDO948oIuLqPPTgfwiUD6k3of3MivB5m3sk9dxA
         9QeRVcm6YKHayZR+msFDIBoo2EGcnA6V+ViWlHyAG9o68XZdvtiKi2QfginbLPALxEO6
         FWw2chPuw3/V7f73INLr0p9DrJNb9XQvPaIzyj1r1EvWnlBtHUgo07qfCgP369GjTgxg
         X5ZYHMfuhfI3FQu/JxN9RsaOZEeQha9SUf50aYsWm1P1Ng+zPSHbN1xGUW/uhhjco/Y1
         xgxfw4P0yDvFGssJOUNOHk9xeDGC0MFAEhOOFRQm/u3kn6WZ2Kl0mRTE/QqEvi50pSxj
         M8Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXM20yZfxrQWPr2+WmOZhQNdNdszdcLhZ9SX6E7YXwWWGfXGqWDmVMwPzz7lIhqw1WJwepc+SWCup8dEr4gEDxd4nOkw/h7RwF0
X-Gm-Message-State: AOJu0YxV59XOSjyPr0/TcPsylF5D/UyryJr8M27T4kM+CrPL2Tb5ko6B
	2/9tfBcqSWN1j6SFGCCE+IyRl2evMWsfsuHAtol1TVDisOnv4bwsr3ThmIMz0eRZHyfRAHQmfax
	sF/mPxk3zawOAn6/GwL02qlf4twjskYhINOfWR4mPxmAObYJKvAADMRni8Q==
X-Received: by 2002:a05:6214:2245:b0:68e:ecf5:8bdd with SMTP id c5-20020a056214224500b0068eecf58bddmr25668842qvc.9.1708431544157;
        Tue, 20 Feb 2024 04:19:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIcand39HCFOjLEqoA7Cqkzmz+CBrXH4h1hJteepwSvSM4zV5FZN3L4vxVwOdNeSL+B/mSlA==
X-Received: by 2002:a05:6214:2245:b0:68e:ecf5:8bdd with SMTP id c5-20020a056214224500b0068eecf58bddmr25668815qvc.9.1708431543759;
        Tue, 20 Feb 2024 04:19:03 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id mw2-20020a05621433c200b0068f3291f860sm4309855qvb.95.2024.02.20.04.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:19:03 -0800 (PST)
Date: Tue, 20 Feb 2024 13:19:00 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	linux-can@vger.kernel.org,
	Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.
Message-ID: <ZdSYtPtn5UzKNhAi@fedora>
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

Hello Mikail,

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
> > +\end{description}
> > +
> > +\subsubsection{Feature bit requirements}\label{sec:Device Types / CAN Device / Feature bits / Feature bit requirements}
> > +
> > +Some CAN feature bits require other CAN feature bits:
> > +\begin{description}
> > +\item[VIRTIO_CAN_F_RTR_FRAMES] Requires VIRTIO_CAN_F_CAN_CLASSIC.
> > +\end{description}
> > +
> > +It is required that at least one of VIRTIO_CAN_F_CAN_CLASSIC and
> > +VIRTIO_CAN_F_CAN_FD is negotiated.
> > +
> > +\subsection{Device configuration layout}\label{sec:Device Types / CAN Device / Device configuration layout}
> > +
> > +Device configuration fields are listed below, they are read-only for a
> > +driver. The \field{status} always exists. A single read-only bit (for
> > +the driver) is currently defined for \field{status}:
> > +
> > +\begin{lstlisting}
> > +struct virtio_can_config {
> > +#define VIRTIO_CAN_S_CTRL_BUSOFF (1 << 0)
> > +        le16 status;
> > +};
> > +\end{lstlisting}
> > +
> > +The bit VIRTIO_CAN_S_CTRL_BUSOFF in \field{status} is used to indicate
> > +the unsolicited CAN controller state change from started to stopped due
> > +to a detected bus off condition.
> > +
> > +\drivernormative{\subsubsection}{Device Initialization}{Device Types / CAN Device / Device Operation / Initialization}
> > +
> > +The driver MUST populate the \field{Rxq} with empty device-writeable
> > +buffers of at least the size of struct virtio_can_rx, see section
> > +\ref{struct virtio_can_rx}.
> > +
> > +\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device Operation}
> > +
> > +A device operation has an outcome which is described by one of the
> > +following values:
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_CAN_RESULT_OK     0
> > +#define VIRTIO_CAN_RESULT_NOT_OK 1
> > +\end{lstlisting}
> > +
> > +Other values are to be treated like VIRTIO_CAN_RESULT_NOT_OK.
> > +
> > +\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device Operation / Controller Mode}
> > +
> > +The general format of a request in the \field{Controlq} is
> > +
> > +\begin{lstlisting}
> > +struct virtio_can_control_out {
> > +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
> > +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
> > +        le16 msg_type;
> > +};
> > +\end{lstlisting}
> > +
> > +To participate in bus communication the CAN controller is started by
> > +sending a VIRTIO_CAN_SET_CTRL_MODE_START control message, to stop
> > +participating in bus communication it is stopped by sending a
> > +VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
> > +confirmed by the result of the operation.
> > +
> > +\begin{lstlisting}
> > +struct virtio_can_control_in {
> > +        u8 result;
> > +};
> > +\end{lstlisting}
> > +
> > +If the transition succeeded the \field{result} is VIRTIO_CAN_RESULT_OK
> > +otherwise it is VIRTIO_CAN_RESULT_NOT_OK. If a status update is
> > +necessary, the device updates the configuration \field{status} before
> > +marking the request used. As the configuration \field{status} change is
> > +caused by a request from the driver the device is allowed to omit the

Is this to indicate that when a driver requests a change, the device can
omit notifying of the change? As I understand the specification, the
device can omit the notification, but the change must still occur? Is it
possible for the device to omit the change as well? What else could have
triggered the status change if it wasn't the driver?

Thanks.


