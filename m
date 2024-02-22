Return-Path: <linux-can+bounces-345-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D42185F6F2
	for <lists+linux-can@lfdr.de>; Thu, 22 Feb 2024 12:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D09B23252
	for <lists+linux-can@lfdr.de>; Thu, 22 Feb 2024 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0517445C10;
	Thu, 22 Feb 2024 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+lxRftN"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA545BEF
	for <linux-can@vger.kernel.org>; Thu, 22 Feb 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708601446; cv=none; b=r6O/4VPIRu4A1meFk9nEFwHJU4WPxEg+PPxTLNQpsBBDN5O4htiQ41yGiJAaHJUK9e7/50jJb61ioZVbvp6OkbOxVtTQzAmsap2jW4jDqmaTdxP+SArqxtTuhZeQsfS2Y4SZS62bCf8xDfsMaz5lVVy/m5xwkVB7QSrqDf5mTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708601446; c=relaxed/simple;
	bh=3h36aBxv2Xpsuz7mavIJ0AgTe0GQGbzyoAT6PJXcr44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJekkHfCMcYc21TClqB96TdA4zhfSm6xTgROcOSQZE8OLbWD4fzKRLDEGju1OeRzh30li/lhvEGLkbnWBj+q6w7h9KmzIMCOjKjSXHkRhfSCOme55boTbuoA6XJfbioRRcT3BKf0ZkotTwlYRvdOYOPgVBsiaDYPobh/nCR34vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+lxRftN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708601443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDzaL7dkQKTAnSLCd6E782i4+1z/ltyP67G/xrL3Euc=;
	b=Q+lxRftNarz69VqunpmhDS1ObyUCZ/Ufq3DhaA4QWGfWQTD83U+n1yx7fr5M45ITo1wFTw
	0sPqmPms4a2yavBvYKG4D85YrsnZJoqrJlHhemHB5HOUgeazr3l7vwEAvCiMJtiMwrG1d7
	vBpAaawqwNf6b5mvjM2k4LhzNnss7JM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-HCZCdKiQMeiJCj0GmmL7pg-1; Thu, 22 Feb 2024 06:30:42 -0500
X-MC-Unique: HCZCdKiQMeiJCj0GmmL7pg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d23683df7fso38947951fa.1
        for <linux-can@vger.kernel.org>; Thu, 22 Feb 2024 03:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708601440; x=1709206240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDzaL7dkQKTAnSLCd6E782i4+1z/ltyP67G/xrL3Euc=;
        b=YYk1OOoGkK7ZdyuLGXLJ1NusHeph2Agry2z631YHBanOIbU6R3/lHVePPpA6itHqaa
         w/+o3ojjHXtLHnLwfOKvQOtFb+R2UZQ+F+ykU6/tf9SU4nDnHwK0TmHan0bT3FgAT5on
         usKMs3TUR36x5qrD/hutjwsIW0J3kR31OQbnDdSh8KHSC6J07zFJ+CAzrfuuuSeudkMS
         1OxTKd85ilENtJPaltUnGnXa+e8XbjZuuGn1wAjAEY/73fiM3tJwjgk2iTrwpM0LB9mC
         HIaf2FfSYC+jHkN5wlFGOlgFC62b5X2wb+n6VWnE2Tk4wLcgeFRFzV6QQLB/YpOMsbEs
         y84Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFZ55Mbduh7smQ0FnZz3uuXhWqGnU5HnwXa3ZJUSm8oGms9QC3QRTBz3KAf7tuPJxjL9YXxrpjj0bJsHn6/89yfBcPFScaZF7w
X-Gm-Message-State: AOJu0YxGUlh0kAm0HtSm2DhkLAufpqaA5dyD85QotMlx17HXaXps0v95
	kfQTtOEdX+WfnPjxAulsCc+b6l7hG9/SsCV6y2VPt1XjbZ8vsba+kaDetmeZMN3x9ET15te+qH/
	ab6z4Pqvg4zXw6jBeVrOeCzUVPAVYUySMNAHI4ZOp81Eu3nzBGwv+OfLfCKNC+gsrcw==
X-Received: by 2002:ac2:4c8a:0:b0:512:cc50:c3e0 with SMTP id d10-20020ac24c8a000000b00512cc50c3e0mr4715137lfl.52.1708601440450;
        Thu, 22 Feb 2024 03:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEq+x1REUNVFGd5VtK6cp2OO6c7Y72w/I7ThXIZTRwmdgEx9QjIYZ6RBr5koxNjcRf88ZSbTQ==
X-Received: by 2002:ac2:4c8a:0:b0:512:cc50:c3e0 with SMTP id d10-20020ac24c8a000000b00512cc50c3e0mr4715117lfl.52.1708601439922;
        Thu, 22 Feb 2024 03:30:39 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id l40-20020a05600c1d2800b0041276d96351sm5415049wms.3.2024.02.22.03.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:30:39 -0800 (PST)
Date: Thu, 22 Feb 2024 12:30:37 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	linux-can@vger.kernel.org,
	Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.
Message-ID: <ZdcwXSoc0sxbjS1Z@fedora>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdSYtPtn5UzKNhAi@fedora>
 <0874278c-9497-414e-b1e5-4ebdf5db6da7@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0874278c-9497-414e-b1e5-4ebdf5db6da7@opensynergy.com>

On Wed, Feb 21, 2024 at 04:42:18PM +0100, Mikhail Golubev-Ciuchea wrote:
> Hi Matias,
> 
> On 2/20/24 13:19, Matias Ezequiel Vara Larsen wrote:
> > Hello Mikail,
> > 
> > On Mon, Jan 08, 2024 at 06:18:50PM +0100, Mikhail Golubev-Ciuchea wrote:
> > > Hi all!
> > > 
> > > I kindly request a vote.
> > > 
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/186
> > > 
> > > 
> > > Best wishes,
> > > Mikhail Golubev-Ciuchea
> > > 
> > > 
> > > 
> > > On 6/9/23 16:22, Mikhail Golubev-Ciuchea wrote:
> > > > From: Harald Mommer <harald.mommer@opensynergy.com>
> > > > 
> > > > virtio-can is a virtual CAN device. It provides a way to give access to
> > > > a CAN controller from a driver guest. The device is aimed to be used by
> > > > driver guests running a HLOS as well as by driver guests running a
> > > > typical RTOS as used in controller environments.
> > > > 
> > > > Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
> > > > Signed-off-by: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>
> > > > ---
> > > > 
> > > > RFC v3:
> > > > * Add length fields in CAN RX and TX messages.
> > > > * Replace bus off indication queue with a config space bit.
> > > > * Clarify handling of unknown flag bits set in CAN frame.
> > > > * Remove MISRA C suffixes in constants.
> > > > * Reserve 16 bits in RX/TX messages for CAN XL priority.
> > > > * Reserve 8 bits in RX/TX messages for CAN classic DLC.
> > > > * Rework according to general virtio spec POV.
> > > > * Implementation:
> > > >     driver: https://lore.kernel.org/all/20230607145613.133203-1-Mikhail.Golubev-Ciuchea@opensynergy.com/
> > > >     QEmu device: https://github.com/OpenSynergy/qemu/tree/virtio-can-spec-rfc-v3
> > > > 
> > > > RFC v2:
> > > > * Add CAN classic feature flag.
> > > > * Add feature flag VIRTIO_CAN_F_LATE_TX_ACK.
> > > > * Add feature flag VIRTIO_CAN_F_RTR_FRAMES.
> > > > * Reserve 32 bits in RX/TX messages.
> > > > * Remove priorities of messages.
> > > > 
> > > >    conformance.tex                         |  12 +-
> > > >    content.tex                             |   1 +
> > > >    device-types/can/description.tex        | 249 ++++++++++++++++++++++++
> > > >    device-types/can/device-conformance.tex |   8 +
> > > >    device-types/can/driver-conformance.tex |   7 +
> > > >    introduction.tex                        |   2 +
> > > >    6 files changed, 275 insertions(+), 4 deletions(-)
> > > >    create mode 100644 device-types/can/description.tex
> > > >    create mode 100644 device-types/can/device-conformance.tex
> > > >    create mode 100644 device-types/can/driver-conformance.tex
> > > > 
> > > > diff --git a/conformance.tex b/conformance.tex
> > > > index 01ccd69..a07ef02 100644
> > > > --- a/conformance.tex
> > > > +++ b/conformance.tex
> > > > @@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > > >    \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
> > > >    \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance},
> > > >    \ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
> > > > -\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance} or
> > > > -\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
> > > > +\ref{sec:Conformance / Driver Conformance / GPIO Driver Conformance},
> > > > +\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance} or
> > > > +\ref{sec:Conformance / Driver Conformance / CAN Driver Conformance}.
> > > >        \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
> > > >      \end{itemize}
> > > > @@ -59,8 +60,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > > >    \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
> > > >    \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance},
> > > >    \ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
> > > > -\ref{sec:Conformance / Device Conformance / GPIO Device Conformance} or
> > > > -\ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
> > > > +\ref{sec:Conformance / Device Conformance / GPIO Device Conformance},
> > > > +\ref{sec:Conformance / Device Conformance / PMEM Device Conformance} or
> > > > +\ref{sec:Conformance / Device Conformance / CAN Device Conformance}.
> > > >        \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
> > > >      \end{itemize}
> > > > @@ -152,6 +154,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > > >    \input{device-types/scmi/driver-conformance.tex}
> > > >    \input{device-types/gpio/driver-conformance.tex}
> > > >    \input{device-types/pmem/driver-conformance.tex}
> > > > +\input{device-types/can/driver-conformance.tex}
> > > >    \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
> > > > @@ -238,6 +241,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > > >    \input{device-types/scmi/device-conformance.tex}
> > > >    \input{device-types/gpio/device-conformance.tex}
> > > >    \input{device-types/pmem/device-conformance.tex}
> > > > +\input{device-types/can/device-conformance.tex}
> > > >    \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
> > > >    A conformant implementation MUST be either transitional or
> > > > diff --git a/content.tex b/content.tex
> > > > index d2ab9eb..8806b57 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -765,6 +765,7 @@ \chapter{Device Types}\label{sec:Device Types}
> > > >    \input{device-types/scmi/description.tex}
> > > >    \input{device-types/gpio/description.tex}
> > > >    \input{device-types/pmem/description.tex}
> > > > +\input{device-types/can/description.tex}
> > > >    \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> > > > diff --git a/device-types/can/description.tex b/device-types/can/description.tex
> > > > new file mode 100644
> > > > index 0000000..2511d9c
> > > > --- /dev/null
> > > > +++ b/device-types/can/description.tex
> > > > @@ -0,0 +1,249 @@
> > > > +\section{CAN Device}\label{sec:Device Types / CAN Device}
> > > > +
> > > > +virtio-can is a virtio based CAN (Controller Area Network) controller.
> > > > +It is used to give a virtual machine access to a CAN bus. The CAN bus
> > > > +might either be a physical CAN bus or a virtual CAN bus between virtual
> > > > +machines or a combination of both.
> > > > +
> > > > +\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
> > > > +
> > > > +36
> > > > +
> > > > +\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues}
> > > > +
> > > > +\begin{description}
> > > > +\item[0] Txq
> > > > +\item[1] Rxq
> > > > +\item[2] Controlq
> > > > +\end{description}
> > > > +
> > > > +The \field{Txq} is used to send CAN packets to the CAN bus.
> > > > +
> > > > +The \field{Rxq} is used to receive CAN packets from the CAN bus.
> > > > +
> > > > +The \field{Controlq} is used to control the state of the CAN controller.
> > > > +
> > > > +\subsection{Feature bits}{Device Types / CAN Device / Feature bits}
> > > > +
> > > > +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
> > > > +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
> > > > +CAN~2.0B Extended CAN IDs is considered as mandatory for this
> > > > +specification.
> > > > +
> > > > +\begin{description}
> > > > +
> > > > +\item[VIRTIO_CAN_F_CAN_CLASSIC (0)]
> > > > +
> > > > +The device supports classic CAN frames with a maximum payload size of 8
> > > > +bytes.
> > > > +
> > > > +\item[VIRTIO_CAN_F_CAN_FD (1)]
> > > > +
> > > > +The device supports CAN FD frames with a maximum payload size of 64
> > > > +bytes.
> > > > +
> > > > +\item[VIRTIO_CAN_F_RTR_FRAMES (2)]
> > > > +
> > > > +The device supports RTR (remote transmission request) frames. RTR frames
> > > > +are only supported with classic CAN.
> > > > +
> > > > +\item[VIRTIO_CAN_F_LATE_TX_ACK (3)]
> > > > +
> > > > +The virtio CAN device marks transmission requests from the \field{Txq}
> > > > +as used after the CAN message has been transmitted on the CAN bus. If
> > > > +this feature bit has not been negotiated, the device is allowed to mark
> > > > +transmission requests already as used when the CAN message has been
> > > > +scheduled for transmission but might not yet have been transmitted on
> > > > +the CAN bus.
> > > > +
> > > > +\end{description}
> > > > +
> > > > +\subsubsection{Feature bit requirements}\label{sec:Device Types / CAN Device / Feature bits / Feature bit requirements}
> > > > +
> > > > +Some CAN feature bits require other CAN feature bits:
> > > > +\begin{description}
> > > > +\item[VIRTIO_CAN_F_RTR_FRAMES] Requires VIRTIO_CAN_F_CAN_CLASSIC.
> > > > +\end{description}
> > > > +
> > > > +It is required that at least one of VIRTIO_CAN_F_CAN_CLASSIC and
> > > > +VIRTIO_CAN_F_CAN_FD is negotiated.
> > > > +
> > > > +\subsection{Device configuration layout}\label{sec:Device Types / CAN Device / Device configuration layout}
> > > > +
> > > > +Device configuration fields are listed below, they are read-only for a
> > > > +driver. The \field{status} always exists. A single read-only bit (for
> > > > +the driver) is currently defined for \field{status}:
> > > > +
> > > > +\begin{lstlisting}
> > > > +struct virtio_can_config {
> > > > +#define VIRTIO_CAN_S_CTRL_BUSOFF (1 << 0)
> > > > +        le16 status;
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +The bit VIRTIO_CAN_S_CTRL_BUSOFF in \field{status} is used to indicate
> > > > +the unsolicited CAN controller state change from started to stopped due
> > > > +to a detected bus off condition.
> > > > +
> > > > +\drivernormative{\subsubsection}{Device Initialization}{Device Types / CAN Device / Device Operation / Initialization}
> > > > +
> > > > +The driver MUST populate the \field{Rxq} with empty device-writeable
> > > > +buffers of at least the size of struct virtio_can_rx, see section
> > > > +\ref{struct virtio_can_rx}.
> > > > +
> > > > +\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device Operation}
> > > > +
> > > > +A device operation has an outcome which is described by one of the
> > > > +following values:
> > > > +
> > > > +\begin{lstlisting}
> > > > +#define VIRTIO_CAN_RESULT_OK     0
> > > > +#define VIRTIO_CAN_RESULT_NOT_OK 1
> > > > +\end{lstlisting}
> > > > +
> > > > +Other values are to be treated like VIRTIO_CAN_RESULT_NOT_OK.
> > > > +
> > > > +\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device Operation / Controller Mode}
> > > > +
> > > > +The general format of a request in the \field{Controlq} is
> > > > +
> > > > +\begin{lstlisting}
> > > > +struct virtio_can_control_out {
> > > > +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
> > > > +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
> > > > +        le16 msg_type;
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +To participate in bus communication the CAN controller is started by
> > > > +sending a VIRTIO_CAN_SET_CTRL_MODE_START control message, to stop
> > > > +participating in bus communication it is stopped by sending a
> > > > +VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
> > > > +confirmed by the result of the operation.
> > > > +
> > > > +\begin{lstlisting}
> > > > +struct virtio_can_control_in {
> > > > +        u8 result;
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +If the transition succeeded the \field{result} is VIRTIO_CAN_RESULT_OK
> > > > +otherwise it is VIRTIO_CAN_RESULT_NOT_OK. If a status update is
> > > > +necessary, the device updates the configuration \field{status} before
> > > > +marking the request used. As the configuration \field{status} change is
> > > > +caused by a request from the driver the device is allowed to omit the
> > 
> > Is this to indicate that when a driver requests a change, the device can
> > omit notifying of the change? As I understand the specification, the
> > device can omit the notification, but the change must still occur? Is it
> > possible for the device to omit the change as well? What else could have
> > triggered the status change if it wasn't the driver?
> > 
> > Thanks.
> > 
> 
> The change request notification OK/NOT_OK for every mode transition request
> is there in any case. In some cases the device would additionally notify the
> driver about the controller status via 'virtio_can_config' in config space
> (config space change notification mechanism), e.g. in case of a BusOff event
> on the device side. Although, it is possible to omit the config space
> notification e.g. when transitioning to stopped mode.
> 

Thanks for the clarification. I think I got confused with the following
sentence:

`As the configuration status change is caused by a request from the
driver the device is allowed to omit the configuration change
notification here.`

I think this could be rewritten as follows:

`The device may omit the configuration change notification as the
configuration status change is requested by the driver.`

This change is, however, minor, so feel free to ignore it.

Matias


