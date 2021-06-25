Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7153B4031
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhFYJWF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 05:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFYJWE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Jun 2021 05:22:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2277C061574
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 02:19:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwhzw-0004TJ-FJ; Fri, 25 Jun 2021 11:19:40 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6633:1401:6bbf:57ef])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2F0F4643690;
        Fri, 25 Jun 2021 09:19:39 +0000 (UTC)
Date:   Fri, 25 Jun 2021 11:19:38 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Harald Mommer <hmo@opensynergy.com>
Cc:     linux-can@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: review of virtio-can (was: Re: MSG_CONFIRM RX messages with
 SocketCAN known as unreliable under heavy load?)
Message-ID: <20210625091938.5s7g2eiuz52vx7fh@pengutronix.de>
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
 <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pzrznloxh3zdh5y7"
Content-Disposition: inline
In-Reply-To: <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--pzrznloxh3zdh5y7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.06.2021 17:21:15, Harald Mommer wrote:
> First draft went to virtio-comment@lists.oasis-open.org and
> virtio-dev@lists.oasis-open.org.
>=20
> https://markmail.org/search/?q=3Dvirtio-can&q=3Dlist%3Aorg.oasis-open.lis=
ts.virtio-comment#query:virtio-can%20list%3Aorg.oasis-open.lists.virtio-com=
ment+page:1+mid:hdxj35fsthypllkt+state:results

> [virtio-dev] [PATCH 1/1] [RFC] virtio-can: Add the device specification.
> Harald Mommer Thu, 01 Apr 2021 08:21:09 -0700
>=20
> virtio-can is a virtual CAN device. It provides a way to give access to
> a CAN controller from a driver guest. The device is aimed to be used by
> driver guests running a HLOS as well as by driver guests running a
> typical RTOS as used in controller environments.

Let's open the focus of this driver and not limit us to RTOSes.

> ---
>  content.tex      |   1 +
>  introduction.tex |   3 +
>  virtio-can.tex   | 245 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 virtio-can.tex
>=20
> diff --git a/content.tex b/content.tex
> index e536fd4..c1604db 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -6564,6 +6564,7 @@ \subsubsection{Legacy Interface: Framing=20
> Requirements}\label{sec:Device
>  \input{virtio-mem.tex}
>  \input{virtio-i2c.tex}
>  \input{virtio-scmi.tex}
> +\input{virtio-can.tex}
> =20
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> =20
> diff --git a/introduction.tex b/introduction.tex
> index 7204b24..84ea5c0 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -79,6 +79,9 @@ \section{Normative References}\label{sec:Normative Refe=
rences}
>         \phantomsection\label{intro:SCMI}\textbf{[SCMI]} &
>         Arm System Control and Management Interface, DEN0056,
>         \newline\url{https://developer.arm.com/docs/den0056/c}, version C=
 and=20
> any future revisions\\
> +       \phantomsection\label{intro:CAN_Driver}\textbf{[CAN Driver]} &
> +       Specification of CAN Driver -- AUTOSAR CP R20-11,

As mentioned before don't make this AUTOSAR specific.

> +      =20
> \newline\url{https://www.autosar.org/fileadmin/user_upload/standards/clas=
sic/20-11/AUTOSAR_SWS_CANDriver.pdf}\\
> =20
>  \end{longtable}
> =20
> diff --git a/virtio-can.tex b/virtio-can.tex
> new file mode 100644
> index 0000000..c343759
> --- /dev/null
> +++ b/virtio-can.tex
> @@ -0,0 +1,245 @@
> +\section{CAN Device}\label{sec:Device Types / CAN Device}
> +
> +virtio-can is a virtio based CAN (Controller Area Network) device. It is
> +used to give a virtual machine access to a CAN bus. The CAN bus may
> +either be a physical CAN bus or a virtual CAN bus between virtual
> +machines or a combination of both.
> +
> +This section relies on definitions made by the AUTOSAR
> +\hyperref[intro:CAN_Driver]{CAN Driver} specification.

Please refer to the ISO CAN specs.

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
> +\subsection{Feature Bits}\label{sec:Device Types / CAN Device / Feature =
Bits}
> +
> +The virtio-can device always supports classic CAN frames with a maximum
> +payload size of 8 bytes.
> +
> +Actual CAN controllers support Extended CAN IDs with 29 bits (CAN~2.0B)
> +as well as Standard CAN IDs with 11 bits (CAN~2.0A). The support of
> +CAN~2.0B Extended CAN IDs is considered as mandatory for this
> +specification.

Let's make Classical CAN a feature just like CAN-FD. There might be
Controller Implementations that only support CAN-FD.

> +
> +\begin{description}
> +
> +\item[VIRTIO_CAN_F_CAN_FD (0)]
> +
> +In addition to classic CAN frames the device supports CAN FD frames with
> +a maximum payload size of 64 bytes.
>

OK

> +\end{description}
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / CAN De=
vice /=20
> Device configuration layout}
> +
> +All fields of this configuration are always available and read-only for
> +the driver.
> +
> +\begin{lstlisting}
> +struct virtio_can_config {
> +        le16 lo_prio_count;=20
> +        le16 hi_prio_count;
> +};
> +\end{lstlisting}

Have you had a look at the virtio-net? There is already support for
multiple queue pairs. Though, I haven't found any notion of priorities
among the queues.

> +
> +To operate the Virtio CAN device it may be necessary to know some basic
> +properties of the underlying physical CAN controller hardware and its
> +configuration.
> +
> +Physical CAN controllers may support transmission by putting messages
> +into FIFOs first and / or by using transmit buffers directly. The user
> +of the Virtio CAN driver may need to know
> +
> +\begin{itemize}
> +\item Number of TX FIFO places for non time critical CAN messages
> +\item Number of TX buffers for high priority CAN messages
> +\end{itemize}

IMHO the FIFO depth is optional and should be per queue.

> +
> +to schedule an optimal transmission of CAN messages. Non time critical
> +messages may be sent via a FIFO where they may suffer "Inner Priority
> +Inversion" (\hyperref[intro:CAN_Driver]{CAN Driver} chapter 2.1). High
> +priority messages are preferably sent directly to a transmit buffer
> +where they immediately participate in CAN bus arbitration.
> +

Let's use multiple queues like Ethernet has.

> +\subsection{Device Initialization}\label{sec:Device Types / CAN Device /=
=20
> Device Initialization}
> +
> +\begin{enumerate}
> +
> +\item Read the feature bits and negotiate with the device.
> +
> +\item Fill the virtqueue \field{Rxq} with empty buffers to be ready for
> +the reception of CAN messages.
> +
> +\item Fill the virtqueue \field{Indicationq} with empty buffers so that
> +the CAN device is able to provide status change indications to the
> +virtio CAN driver.
> +
> +\item Read the CAN controller properties using the \field{Controlq}.
> +
> +\item Start the CAN controller using the \field{Controlq}.

How does this work on Ethernet?

> +
> +\end{enumerate}
> +
> +\subsection{Device Operation}\label{sec:Device Types / CAN Device / Devi=
ce=20
> Operation}
> +
> +A device operation has an outcome which is described by one of the
> +following values:
> +
> +\begin{lstlisting}
> +#define VIRTIO_CAN_RESULT_OK     0u
> +#define VIRTIO_CAN_RESULT_NOT_OK 1u
> +\end{lstlisting}
> +
> +The type of a CAN message identifier is identified by the most
> +significant 2 bits of the internally used 32 bit value. This matches the
> +definition for Can_IdType in

I'm missing RTR messages.

Please don't cramp to much information, or better say any additional
information in the remaining 3 bits of the 32 bit CAN-id.

You defined a struct for the CAN messages, so add all needed flags to a
proper flags field.

> +\hyperref[intro:CAN_Driver]{CAN Driver} chapter 8.2.3.
> +
> +\begin{lstlisting}
> +#define VIRTIO_CAN_ID_TYPE_STANDARD    0x00000000U
> +#define VIRTIO_CAN_ID_TYPE_STANDARD_FD 0x40000000U
> +#define VIRTIO_CAN_ID_TYPE_EXTENDED    0x80000000U
> +#define VIRTIO_CAN_ID_TYPE_EXTENDED_FD 0xC0000000U
> +\end{lstlisting}
> +
> +\subsubsection{Controller Mode}\label{sec:Device Types / CAN Device / De=
vice=20
> Operation / Controller Mode}
> +
> +The general format of a request in the \field{Controlq} is
> +
> +\begin{lstlisting}
> +struct virtio_can_control_out {
> +#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201u
> +#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202u
> +        le16 msg_type;=20
> +};
> +\end{lstlisting}

How does Ethernet handle this?

> +
> +To participate in bus communication the CAN controller must be started
> +by sending a VIRTIO_CAN_SET_CTRL_MODE_START control message,
> +to stop participating in bus communication it must be stopped by sending
> +a VIRTIO_CAN_SET_CTRL_MODE_STOP control message. Both requests are
> +confirmed by the result of the operation.
> +
> +\begin{lstlisting}
> +struct virtio_can_set_ctrl_mode_in {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +If the transition succeeded the result shall be VIRTIO_CAN_RESULT_OK
> +otherwise it shall be VIRTIO_CAN_RESULT_NOT_OK. The request shall be put
> +into the used queue when the CAN controller finalized the transition to
> +the requested controller mode.
> +
> +A transition to STOPPED state cancels all CAN messages pending for
> +transmission. A state transition to STOPPED state shall trigger to put
> +all CAN messages pending for transmission into the used queue with
> +result VIRTIO_CAN_RESULT_NOT_OK.
> +
> +Initially the CAN controller is in STOPPED state.
> +
> +\subsubsection{CAN Message Transmission}\label{sec:Device Types / CAN De=
vice /=20
> Device Operation / CAN Message Transmission}
> +
> +Messages may be transmitted by placing outgoing CAN messages in the
> +virtqueue \field{Txq}.
> +
> +\begin{lstlisting}
> +struct virtio_can_tx_out {
> +#define VIRTIO_CAN_TX 0x0001u
> +        le16 msg_type;

make this 32 bit and add flags for extended CAN messages, RTR, CAN-FD.
We have to discuss if we need a bit rate switch flag.

> +        le16 priority;

Let's handle priority by using different queues.

> +        le32 can_id;
> +        u8 sdu[];

Where's the dlc or len information?

We have to discuss if we want to pass dlc (0x0...0xf for both Classical
CAN and CAN-FD) or len (0...8 for Classical CAN and 0...64 for CAN-FD).

> +};
> +
> +struct virtio_can_tx_in {
> +        u8 result;
> +};
> +\end{lstlisting}
> +
> +Priority is 0 for low priority and 1 for high priority CAN messages.
> +
> +The actual length of the SDU can be calculated from the length of the de=
vice
> +read-only descriptor.
> +
> +To avoid internal priority inversion in the \field{Txq} the user of the
> +driver may do a book keeping of in flight transmission requests and
> +defer sending of TX messages until the chosen transmission resource
> +becomes available.
> +
> +If priority, can_id or SDU length are out of range or the CAN controller
> +is in an invalid state result shall be set to VIRTIO_CAN_RESULT_NOT_OK
> +and the message shall not be scheduled for transmission. Sending a CAN
> +message with a priority with 0 transmission places configured shall
> +be considered as priority being out of range.
> +
> +If the parameters are valid the message is scheduled for transmission
> +and result is set to VIRTIO_CAN_OK. The transmission request should be
> +put into the used queue after the physical CAN controller acknowledged
> +the transmission on the CAN bus (may have to be put under a feature flag
> +as there may be non AUTOSAR CAN driver backends which don't provide a
> +trigger to do this correctly).

I think this should me mandatory, but we might have a flag or feature
flag to indicate the "quality" if the tx done information. Some HW CAN
devices only provide feedback that they have queued the CAN message, but
no feedback that they have actually transmitted the message.

> +
> +\subsubsection{CAN Message Reception}\label{sec:Device Types / CAN Devic=
e /=20
> Device Operation / CAN Message Reception}
> +
> +Messages can be received by providing empty incoming buffers to the
> +virtqueue \field{Rxq}.
> +
> +\begin{lstlisting}
> +struct virtio_can_rx {
> +#define VIRTIO_CAN_RX 0x0101u
> +        le16 msg_type;
> +        le16 reserved;
> +        le32 can_id;
> +        u8 sdu[];
> +};
> +\end{lstlisting}
> +
> +The structure element reserved may in the future be used to forward an
> +AUTOSAR hoh, see (\hyperref[intro:CAN_Driver]{CAN Driver} chapter 7.6).
> +The value should be set to 0xFFFF.

Please remove any AUTOSAR references.

> +
> +If the feature \field{VIRTIO_CAN_F_CAN_FD} has been negotiated the
> +maximal possible SDU length is 64, if the feature has not been
> +negotiated the maximal possible SDU length is 8.
> +
> +The actual length of the SDU can be calculated from the length of the
> +driver read-only descriptor.
> +
> +\subsubsection{BusOff Indication}\label{sec:Device Types / CAN Device / =
Device=20
> Operation / BusOff Indication}
> +
> +There are certain error conditions so that the physical CAN controller
> +has to stop participating in CAN communication on the bus. If such an
> +error condition occurs the device informs the driver about the
> +unsolicited CAN controller state change by a CAN BusOff indication.
> +
> +\begin{lstlisting}
> +struct virtio_can_busoff_ind {
> +#define VIRTIO_CAN_BUSOFF_IND 0x0301u
> +        le16 msg_type;
> +};
> +\end{lstlisting}
> +
> +After bus-off detection the CAN controller is in STOPPED state. The CAN
> +module does not participate in bus communication any more so all CAN
> +messages pending for transmission must be put into the used queue with
> +result VIRTIO_CAN_RESULT_NOT_OK.
> --=20
> 2.17.1

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pzrznloxh3zdh5y7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDVn6cACgkQqclaivrt
76mNYgf+NDIfWoUsYnb2sJn2J/d+j7eOTdh00Brt1sCTYp1JyZj4t5rnxxnB2ANi
IhwB4QMoOqseUURdEFyCiTi2NAXYQMmuywlnARr7CsCBsZ0eQUD+6hlrDzfb2Y+L
ILjMrDfGktmqzaY3pWbPBogsZ2uWBPW3ozo3QSS0zW9ypzfi8h0gGD+qX1/KG/QY
CyIOc32sEWzPzp3K09DkNy4VzPtWKzKc2/CgD4pXPh/haq+wU6Ttyio+AYKXyrhN
V8v28fGY042yzZQVDoQmh8226DHtuRqa666cz4+3JA42LScbOFqmNJKdcLUV3arC
kbK2mlbznAeHGpczct5SneRODkJvQQ==
=yoG1
-----END PGP SIGNATURE-----

--pzrznloxh3zdh5y7--
