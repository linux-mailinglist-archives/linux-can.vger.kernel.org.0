Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8743461F356
	for <lists+linux-can@lfdr.de>; Mon,  7 Nov 2022 13:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiKGMc2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Nov 2022 07:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiKGMcJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Nov 2022 07:32:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DBF1B7B1
        for <linux-can@vger.kernel.org>; Mon,  7 Nov 2022 04:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667824266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2vJ4cJT2V7iWzdAmquXL5jTwMDh53YVvu6woIkfyrI=;
        b=IZEEIYDv2cYq0Y0b3h+GXOey4Z7WOXkgyqCPEyNYnnz2OgqJXidMaQv1xUU3SQ7z5ub5Wd
        RByCJYxTaxml0U7VoqrOMQ5gR9HieS5A0Ve3T4XdRTeMlpk4f4B7FEfmaMzOl4odKU6E19
        gqiCu/eMj363D7NBRjvzr5VzewjLDD8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-WhWCuyVYMzexeuBmNg2Igw-1; Mon, 07 Nov 2022 07:31:01 -0500
X-MC-Unique: WhWCuyVYMzexeuBmNg2Igw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 443CC862F94;
        Mon,  7 Nov 2022 12:31:01 +0000 (UTC)
Received: from localhost (unknown [10.39.193.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB227140EBF5;
        Mon,  7 Nov 2022 12:31:00 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Harald Mommer <harald.mommer@opensynergy.com>,
        virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org
Cc:     Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-comment] [RFC PATCH v2 1/1] virtio-can: Device
 specification - 2nd RFC draft.
In-Reply-To: <20220825133410.18367-1-harald.mommer@opensynergy.com>
Organization: Red Hat GmbH
References: <20220825133410.18367-1-harald.mommer@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date:   Mon, 07 Nov 2022 13:30:58 +0100
Message-ID: <87o7tj2bgd.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Aug 25 2022, Harald Mommer <harald.mommer@opensynergy.com> wrote:

> virtio-can is a virtual CAN device. It provides a way to give access to
> a CAN controller from a driver guest. The device is aimed to be used by
> driver guests running a HLOS as well as by driver guests running a
> typical RTOS as used in controller environments.

Note that I'm not familiar with CAN, so I'll comment mostly from a
virtio spec POV.

>
> This is the reworked (2nd) version of the specification after having
> gotten some feedback on the virtio lists and the Linux CAN mailing
> lists. (The 1st now outdated version of the specification draft has been
> sent out on 1-Apr-2021 to the virtio lists.) There is now also a virtio
> CAN Linux driver which in the meantime has become good enough to be
> shown.
>
> There were a lot of changes, only mentioning the most important ones
> omitting editorial changes.
>
> - Classic CAN is indeed non-mandatory, so a feature bit is needed.
>   According to ISO all CAN controllers support classic CAN but it may be
>   disabled by configuration. So classic CAN is indeed a feature which
>   may not be available in some environments.
>
> - Introduce a new feature flag VIRTIO_CAN_F_LATE_TX_ACK. While marking
>   as used after the actual transmission has been done on the CAN bus
>   this cannot be implemented reliably in all environments. SocketCAN is
>   affected at least under heavy load for TX and RX.
>
> - RTR frames were requested on the Linux mailing list. They cannot be
>   supported when the underlying CAN driver backend is a 3rd party
>   AUTOSAR driver as AUTOSAR CAN does not support RTR frames. A feature
>   flag VIRTIO_CAN_F_RTR_FRAMES has been added to make support of RTR
>   frames an optional feature.
>
> - Add le32 flags. There is now a reserved field in both RX and TX
>   messages which might serve to contain an AUTOSAR hardware object
>   handle or similar in a future version of the specification without
>   need to change the layout of the RX and TX message structures.
>
> - Removal of priorities and config space. Priorities cannot be supported
>   using SocketCAN, the information delivered in the config space cannot
>   be determined using SocketCAN. Support of different priorities was
>   anyway too much for a first version of a specification. If priorities
>   are supported in a future version there will probably be only 2
>   different priorities, normal and high. In a future version of the
>   specification high priority messages may either be supported by using
>   a flag bit in the TX message but most probably the better solution
>   will be to add add a dedicated 2nd TX queue for high priority messages
>   in a review comment. But as already said priorities are not for now.

Please keep the change log separate from the description.

[Most people add a S-o-b, although we don't enforce DCO.]

> ---
>  conformance.tex  |  27 +++++-
>  content.tex      |   1 +
>  introduction.tex |   2 +
>  virtio-can.tex   | 229 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 255 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-can.tex

(...)

> diff --git a/virtio-can.tex b/virtio-can.tex
> new file mode 100644
> index 0000000..ef4de7b
> --- /dev/null
> +++ b/virtio-can.tex
> @@ -0,0 +1,229 @@
> +\section{CAN Device}\label{sec:Device Types / CAN Device}
> +
> +virtio-can is a virtio based CAN (Controller Area Network) controller.
> +It is used to give a virtual machine access to a CAN bus. The CAN bus
> +might either be a physical CAN bus or a virtual CAN bus between virtual
> +machines or a combination of both.
> +
> +\subsection{Device ID}\label{sec:Device Types / CAN Device / Device ID}
> +
> +36
> +
> +\subsection{Virtqueues}\label{sec:Device Types / CAN Device / Virtqueues}
> +
> +\begin{description}
> +\item[0] Txq
> +\item[1] Rxq
> +\item[2] Controlq
> +\item[3] Indicationq
> +\end{description}
> +
> +The \field{Txq} is used to send CAN packets to the CAN bus.
> +
> +The \field{Rxq} is used to receive CAN packets from the CAN bus.
> +
> +The \field{Controlq} is used to control the state of the CAN controller.
> +
> +The \field{Indicationq} is used to receive unsolicited indications of
> +CAN controller state changes.
> +
> +\devicenormative{\subsubsection}{Feature bits}{Device Types / CAN Device / Feature bits}

We usually don't put the whole feature bit specification into a
normative section, especially as it applies to both device and
driver. A device normative section is for statements like "The device
MUST offer <feature> if <condition> applies", and a driver normative
section for things like "The driver MUST accept <feature> if offered".

> +
> +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
> +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
> +CAN~2.0B Extended CAN IDs is considered as mandatory for this
> +specification.
> +
> +\begin{description}
> +
> +\item[VIRTIO_CAN_F_CAN_CLASSIC (0)]
> +
> +The device supports classic CAN frames with a maximum payload size of 8
> +bytes.
> +
> +\item[VIRTIO_CAN_F_CAN_FD (1)]
> +
> +The device supports CAN FD frames with a maximum payload size of 64
> +bytes.
> +
> +\item[VIRTIO_CAN_F_RTR_FRAMES (2)]
> +
> +The device supports RTR (remote transmission request) frames. RTR frames
> +are only supported with classic CAN.

Are any combinations of those three feature bits valid (both to be
offered, and to be negotiated?) It looks like F_RTR_FRAMES would only
work with F_CAN_CLASSIC?

> +
> +\item[VIRTIO_CAN_F_LATE_TX_ACK (3)]
> +
> +The virtio CAN device marks transmission requests from the \field{Txq}
> +as used after the CAN message has been transmitted on the CAN bus.
> +Without this feature flag negotiated the device is allowed to mark

"If this feature bit has not been negotiated, ..."

> +transmission requests already as used when the CAN message has been
> +scheduled for transmission but might not yet have been transmitted on
> +the CAN bus.
> +
> +\end{description}
> +
> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / CAN Device / Initialization}
> +
> +\begin{enumerate}
> +
> +\item Read the feature bits and negotiate with the device.

I think this step is redundant.

> +
> +\item The driver MUST populate the \field{Rxq} with empty
> +device-writeable buffers of at least the struct virtio_can_rx size to be
> +ready for the reception of CAN messages.

virtio_can_rx is only defined further below, and, IIUC, depends on the
frames that are supported. Can this be expressed as a kind of absolute
value (depending on the negotiated features)?

> +
> +\item The driver MUST populate the \field{Indicationq} with empty
> +device-writeable buffers of at least the struct virtio_can_event_ind size
> +so that the CAN device is able to provide status change indications to the
> +virtio CAN driver.

Is virtio_can_event_ind always supposed to be an le16 value? If yes,
it would probably be easier to specify that here.

> +
> +\end{enumerate}
> +
> +\subsection{Device Operation}\label{sec:Device Types / CAN Device / Device Operation}
> +
> +A device operation has an outcome which is described by one of the
> +following values:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CAN_RESULT_OK     0u
> +#define VIRTIO_CAN_RESULT_NOT_OK 1u
> +\end{lstlisting}
> +
> +Other values are to be treated like VIRTIO_CAN_RESULT_NOT_OK.
> +
> +The type of a CAN message identifier is determined by \field{flags}. The
> +3 most significant bits of
> +\field{can_id} do not bear the information about the type of the CAN
> +message identifier and are 0.
> +
> +\begin{lstlisting}
> +#define VIRTIO_CAN_FLAGS_FD            0x4000U
> +#define VIRTIO_CAN_FLAGS_EXTENDED      0x8000U
> +#define VIRTIO_CAN_FLAGS_RTR           0x2000U
> +\end{lstlisting}

You refer to the "flags" and "can_id" fields, but it is unclear in which
structure. Would this benefit from reordering?

> +
> +\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / Device Operation / Controller Mode}
> +
> +The general format of a request in the \field{Controlq} is
> +
> +\begin{lstlisting}
> +struct virtio_can_control_out {
> +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201u
> +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202u
> +        le16 msg_type; 
> +};
> +\end{lstlisting}
> +
> +To participate in bus communication the CAN controller is started by
> +sending a VIRTIO_CAN_SET_CTRL_MODE_START control message, to stop
> +participating in bus communication it is stopped by sending a
> +VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
> +confirmed by the result of the operation.
> +
> +\begin{lstlisting}
> +struct virtio_can_control_in {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +If the transition succeeded the \field{result} is VIRTIO_CAN_RESULT_OK
> +otherwise it is VIRTIO_CAN_RESULT_NOT_OK. The device marks the request
> +used when the CAN controller has finalized the transition to the
> +requested controller mode.
> +
> +On transition to the STOPPED state the device cancels all CAN messages
> +already pending for transmission and marks them as used with
> +\field{result} VIRTIO_CAN_RESULT_NOT_OK. In the STOPPED state the
> +device marks messages received from the
> +\field{Txq} as used with \field{result} VIRTIO_CAN_RESULT_NOT_OK without
> +transmitting them to the CAN bus.
> +
> +Initially the CAN controller is in the STOPPED state.

Is that an internal state of the controller that can be changed from the
outside?

> +
> +Control queue messages are processed in order.
> +
> +\devicenormative{\subsubsection}{CAN Message Transmission}{Device Types / CAN Device / Device Operation / CAN Message Transmission}

I think this should be a normal subsection, as you describe not only
what the device needs to do, but also what the driver does. Maybe use
separate normative sections for MUST statements?

> +
> +Messages are transmitted by placing outgoing CAN messages in the
> +\field{Txq} virtqueue.

Who places the messages? The driver? Probably better to use active voice
here.

> +
> +\begin{lstlisting}
> +struct virtio_can_tx_out {
> +#define VIRTIO_CAN_TX 0x0001u
> +        le16 msg_type;
> +        le16 reserved;
> +        le32 flags;
> +        le32 can_id;
> +        u8 sdu[];
> +};
> +
> +struct virtio_can_tx_in {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +The length of \field{sdu} is implicit in the length of the device
> +read-only descriptors.

Not sure what this means -- does that mean that any length of the
desriptors is ok, as long as it fits the whole structure?

> +
> +If transmission of a CAN frame type is requested for which support has
> +not been negotiated \field{result} shall be set to
> +VIRTIO_CAN_RESULT_NOT_OK and the message shall not be scheduled for
> +transmission.

This probably should rather be something like "The device MUST reject
any CAN frame type for which support has not been negotiated with
VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT schedule the
message for transmission."

> +
> +If \field{can_id} or field{sdu} length are out of range or the CAN
> +controller is in an invalid state \field{result} shall be set to
> +VIRTIO_CAN_RESULT_NOT_OK and the message shall not be scheduled for
> +transmission.

Same here.

> +
> +If the parameters are valid the message is scheduled for transmission.
> +
> +If feature VIRTIO_CAN_F_CAN_LATE_TX_ACK has been negotiated the
> +transmission request MUST be marked as used with \field{result} set to
> +VIRTIO_CAN_OK after the CAN controller acknowledged the successful
> +transmission on the CAN bus. Without feature
> +VIRTIO_CAN_F_CAN_LATE_TX_ACK negotiated the transmission request MAY
> +already be marked as used with \field{result} set to VIRTIO_CAN_OK when
> +the transmission request has been processed by the virtio CAN device and
> +send down the protocol stack being scheduled for transmission.
> +
> +\subsubsection{CAN Message Reception}\label{sec:Device Types / CAN Device / Device Operation / CAN Message Reception}
> +
> +Messages can be received by providing empty incoming buffers to the
> +virtqueue \field{Rxq}.
> +
> +\begin{lstlisting}
> +struct virtio_can_rx {
> +#define VIRTIO_CAN_RX 0x0101u
> +        le16 msg_type;
> +        le16 reserved;
> +        le32 flags;
> +        le32 can_id;
> +        u8 sdu[];
> +};
> +\end{lstlisting}
> +
> +If the feature VIRTIO_CAN_F_CAN_FD has been negotiated the maximal
> +possible \field{sdu} length is 64, if the feature has not been
> +negotiated the maximal possible \field{sdu} length is 8.
> +
> +The actual length of the \field{sdu} is calculated from the length of the
> +driver read-only descriptors.

So the provided descriptors must fit at least the size of the structure
plus whatever length the negotiated frame sizes support? Can the driver
negotiate F_CAN_FD and still provide descriptors that only allow an sdu
of length 8?

> +
> +\subsubsection{BusOff Indication}\label{sec:Device Types / CAN Device / Device Operation / BusOff Indication}
> +
> +There are certain error conditions so that the physical CAN controller
> +has to stop participating in CAN communication on the bus. If such an
> +error condition occurs the device informs the driver about the
> +unsolicited CAN controller state change by a CAN BusOff indication.
> +
> +\begin{lstlisting}
> +struct virtio_can_event_ind {
> +#define VIRTIO_CAN_BUSOFF_IND 0x0301u
> +        le16 msg_type;
> +};
> +\end{lstlisting}
> +
> +After bus-off detection the CAN controller is in STOPPED state. The CAN
> +module does not participate in bus communication any more so all CAN

s/module/device/ ?

> +messages pending for transmission are put into the used queue with
> +\field{result} VIRTIO_CAN_RESULT_NOT_OK.

