Return-Path: <linux-can+bounces-336-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3161785D5BB
	for <lists+linux-can@lfdr.de>; Wed, 21 Feb 2024 11:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A771F22D2F
	for <lists+linux-can@lfdr.de>; Wed, 21 Feb 2024 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31417F9E4;
	Wed, 21 Feb 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlRNahYk"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B764C1DA52
	for <linux-can@vger.kernel.org>; Wed, 21 Feb 2024 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511888; cv=none; b=IrIWK6YtFLa6GMxtREWkkc8EfFFNOyfAR34hhdBEpo7l0muGo4ruTSbj8g6+OdgXVK3kjO4W44bzztsbbfIY21h6/frRYjGmMaqUhA6+Lc2tPPwqtggKOz/gRI7cz6Kv3dS8J24ZGuj1ZORt1Ti1ucDwtWDxIrP4b9h6Xfo4Ukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511888; c=relaxed/simple;
	bh=HH3SIaza7W9c2VdE9ZWqU3vJ3OqAcw2c9djC43tADPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpQrPbQP0s9+G0u/0W/paExBOy2rxY5y9SoELiv1hK3HpyYnc+pZJ8S5MO54g+ZPRY33EaoSfowFquM2dw2+mwaIAJQy0WJ67vJYOf7zJYpsAXYRkeTG0Lugru05dLkN7uMLwTh86OzM5JYQbhyYa46jmEu93Or+KDp7oyWt7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlRNahYk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708511884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lAVxcOPDEZJxM6i7aQn3XYob29rMeLhU2d9y+FaJgfs=;
	b=QlRNahYkaxgZt/WKAfCJMJITMykIEb8cMZrX7s1mO/voQhLKRU6Ze5AJ1wECXyk8yJUTgR
	bbZBXDOEbwkwNMswIGUMmkf1GKNpQPnzFYBnIJ6MIYEx5PuqI2CXVsSIYJ4rzWmNLSCQGD
	3lEk1YNbvxUMZH3sg8WsSt8RhYt8sVE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-bnqR9Wg5MSiJc4KrZqrFyQ-1; Wed, 21 Feb 2024 05:38:02 -0500
X-MC-Unique: bnqR9Wg5MSiJc4KrZqrFyQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78771ee4ca4so72090885a.0
        for <linux-can@vger.kernel.org>; Wed, 21 Feb 2024 02:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708511882; x=1709116682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAVxcOPDEZJxM6i7aQn3XYob29rMeLhU2d9y+FaJgfs=;
        b=F5YRGiaB5nFu1f29ZXFHos/um0YBgL3zI1U5pCUrR/Akx8BIskYXaY0BAHOJUGnjrP
         T5HSzd1gFVvl6ubSXi6/y3gwbne+CF6woKp3mFoEBBtGjssQb9K3EvW+diyqyyfX+1C5
         fdg3UdUQuWP1JhindPzilDVwaQzRVlsqUOOrS7kqyxzyw1GiCtrjLnDqlWOl92PjZQZR
         IZ7bcRXgx0Pyt4K355dNwci7o8EdSWL8CnAWbh8mSmeuli8kgTaEHYLK5LpGmPB7ulpA
         wVDLF3Z756IXElBFHMDvAgYcjDndu9eBLs/fUgv3Dkk14vME5jN55LS+wTWWpaAcPG38
         PNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6/ykH4pWw1xzMKillCjmIG34cqqpYU8CzGe5lTa2rRSY7E6ewGbMLqwSDW66+IlgfwOqMo4c0/6Eq7wH0aeMsJEfCCq9jtVUF
X-Gm-Message-State: AOJu0YxX0wICp+W5VGj8NtjqpqrxtKuwdFGHnyPFnmNEM1sGnK1ivR6g
	s773CHpboHvmNHXKYA8Q4Zo7wk7qpxUQ2kLQXShCTixdUjnE6nHWfqaa7pu4ojBgT69wx/VGX1X
	g5XPQHaZDLPJgEEkpZGrkC7+slEgJH8U4JeZPBWsLZIrK+6gfKEdybQlGNw==
X-Received: by 2002:a37:e20d:0:b0:787:272a:e298 with SMTP id g13-20020a37e20d000000b00787272ae298mr18443398qki.62.1708511881807;
        Wed, 21 Feb 2024 02:38:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN64Ep5SwWZRxbcPkzLAjml//d/dR75DPVPcwzfci4T9ZHTk1nZWZnJs+Hbs9gkonawtjI7w==
X-Received: by 2002:a37:e20d:0:b0:787:272a:e298 with SMTP id g13-20020a37e20d000000b00787272ae298mr18443383qki.62.1708511881413;
        Wed, 21 Feb 2024 02:38:01 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a0b4400b00785ccbb457esm4224608qkg.81.2024.02.21.02.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 02:38:01 -0800 (PST)
Date: Wed, 21 Feb 2024 11:37:58 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	linux-can@vger.kernel.org,
	Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.
Message-ID: <ZdXShopKyMYPTUva@fedora>
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
> > +configuration change notification here. The device marks the request
> > +used when the CAN controller has finalized the transition to the
> > +requested controller mode.
> > +
> > +On transition to the STOPPED state the device cancels all CAN messages
> > +already pending for transmission and marks them as used with
> > +\field{result} VIRTIO_CAN_RESULT_NOT_OK. In the STOPPED state the
> > +device marks messages received from the
> > +\field{Txq} as used with \field{result} VIRTIO_CAN_RESULT_NOT_OK without
> > +transmitting them to the CAN bus.
> > +
> > +Initially the CAN controller is in the STOPPED state.
> > +
> > +Control queue messages are processed in order.
> > +
> > +\devicenormative{\subsubsection}{CAN Message Transmission}{Device Types / CAN Device / Device Operation / CAN Message Transmission}
> > +
> > +The driver transmits messages by placing outgoing CAN messages in the
> > +\field{Txq} virtqueue.
> > +
> > +\label{struct virtio_can_tx_out}
> > +\begin{lstlisting}
> > +struct virtio_can_tx_out {
> > +#define VIRTIO_CAN_TX 0x0001
> > +        le16 msg_type;
> > +        le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> > +        u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> > +        u8 padding;
> > +        le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> > +#define VIRTIO_CAN_FLAGS_FD            0x4000
> > +#define VIRTIO_CAN_FLAGS_EXTENDED      0x8000
> > +#define VIRTIO_CAN_FLAGS_RTR           0x2000
> > +        le32 flags;
> > +        le32 can_id;
> > +        u8 sdu[];
> > +};
> > +
> > +struct virtio_can_tx_in {
> > +        u8 result;
> > +};
> > +\end{lstlisting}
> > +
> > +The length of the \field{sdu} is determined by the \field{length}.
> > +
> > +The type of a CAN message identifier is determined by \field{flags}. The
> > +3 most significant bits of \field{can_id} do not bear the information
> > +about the type of the CAN message identifier and are 0.
> > +
> > +The device MUST reject any CAN frame type for which support has not been
> > +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT
> > +schedule the message for transmission. A CAN frame with an undefined bit
> > +set in \field{flags} is treated like a CAN frame for which support has
> > +not been negotiated.
> > +
> > +The device MUST reject any CAN frame for which \field{can_id} or
> > +\field{sdu} length are out of range or the CAN controller is in an
> > +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST
> > +NOT schedule the message for transmission.
> > +
I am not very familiar with CAN but how does the device figure out that
the can_id is out of range?

Thanks, Matias.


