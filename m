Return-Path: <linux-can+bounces-391-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3B87BD37
	for <lists+linux-can@lfdr.de>; Thu, 14 Mar 2024 14:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07241F259C7
	for <lists+linux-can@lfdr.de>; Thu, 14 Mar 2024 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84759B52;
	Thu, 14 Mar 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jrazqWX6";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pxWki6+G"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58075821A
	for <linux-can@vger.kernel.org>; Thu, 14 Mar 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421382; cv=pass; b=K8hYN2FvNcy7v8kIJMBNQefSEgpmb3EHO5nS7/Nr1xUfLyHfzBPcVnl1puYhSf7iQrJHHCM6KHoKxHQDhzTjeS2iOvGGOqU8H82cBuF22Nr/Txwhqz1TC69rodCrRSXNOxaC1ZuWIN8ExXbYjiMJlJR1KPlYGvzF+RtaZq6ZbnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421382; c=relaxed/simple;
	bh=9IIiymqfrRmwtroPQ65wrXTkj/Lr8+hsW3UMfZ7J+jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDgkDVAXyqMkBGtT9jF6dF0Rjd9DU37ALgHneYLIRPT6YDsOw6z8hc481NjH1q7ucpYdJXSpVBTSdOOSSGgbcB76mPmCLEMwOe4ujUSFjqKcXhf2OFco/luCtrDR+wgZBHztP0IeY0TNoSYqOSc+dheYOPfaad1moBYuaaDk5E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jrazqWX6; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pxWki6+G; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1710421191; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EnujIgIzF/3zCiHNQRsof5B3esK8T+JFrFcZkJCQmHeEKTIb5ri8Vo+FWujOzECn7D
    CtGOFIuweZ1jE7ITS2KFsWNc94GeJOCihVKo0S51psd92C6jIXVQotm0FxJsVbkoDKj0
    /W9Q+Pu+EfwsBMZqP3ac4m/T1BQBHVVOuUHjnr5RF0HjmsuqefgHdOr0RDrGcB8iyoBh
    cU2A/kYaASVIrnzT3fwPDBEzOGB1gSXRjpljAJtF4+3XLr91oRvH4QzVCo0wYUscJLk+
    cR3nIcp+/fE4aWGnnO6S6IjgX8+OnAGRcgCzc31EXUNQMox6vpC3rwQ0UheBYZCrkmOy
    IsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710421191;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Np+T9Gc+Kf2jvsp0iWiUY0XmovhCeIAma6yObiyeaLA=;
    b=UowYC/3BqQMf1siu/eFaSYQ63kPC5dKV6S0/AcP34Vnb/DNpI6UFMvkQuUn7H4lG7S
    4BlL1+Ffp3PYWemaRz1GVA5agEEXerzIemPET0/yskAL4I1Rm2jLYhhg5Y0vCqMZD4r8
    qiTJfZi3fO+LH3zrDHYEi3CnBdSMucBv8xCNHbys2UbVH/+XV7I/TXN7dQ5krZJheElq
    E+/nErZ9CCrY4lwX5Q4Thnt0IgBhxVpQm6z0yMGTByhuFhW+4DmIOvBLThJQvdT35Q9Z
    Z23YQkwx7CmgobUbWtcNp7sgkyVpTdqptvF29FeXYq0h+gCc3DYVZyUKI1q6tDHVyhp7
    2gfA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710421191;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Np+T9Gc+Kf2jvsp0iWiUY0XmovhCeIAma6yObiyeaLA=;
    b=jrazqWX6YpVS0iyMuc4OaOphgKdHjSFV9AVL85SfmoSO2PCw6Y6HVbfTGbjU0Fit6e
    fF4u340AntGrIGeRWhKsaDzVQu4uCPJlinbhpZOGAfN1OHW7qs4OQDnkb0GaJu9UYrgU
    Q1/jHTk7hcUcHCrW7zOXaxkedmGXGKXLPXHSGUzN+KUz7Dyhjbq7/vq4PSEfqu8l5J48
    xA7VNjjxCBwiZGg31EoPYFjE+/o4X8mq9ImoFFbw++vquBBq6+7nxD7mqcNpubDTzcYV
    Qp8SUccAEf+g65tDnpY5sTQHlsR0InZINLmdTf9mJgEKM6q3wrHOChT5idswt2xCHVdl
    eelQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710421191;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Np+T9Gc+Kf2jvsp0iWiUY0XmovhCeIAma6yObiyeaLA=;
    b=pxWki6+Gpkr4gVwIDhwEPLzXDDerW72YuIu6Re5F+zMUPATL2PWKBMqqZdQHWKSs98
    aZzbneLuFClWJuodzUAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0UTfbD7eAbOcxbilfMdrdQ0RDrXBew=="
Received: from [IPV6:2a00:6020:4a8e:5010:a9ce:2177:7a13:494a]
    by smtp.strato.de (RZmta 50.2.2 AUTH)
    with ESMTPSA id K55d2102ECxo8zj
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 14 Mar 2024 13:59:50 +0100 (CET)
Message-ID: <a8d158dc-0488-491a-bf68-64e984d9a7fa@hartkopp.net>
Date: Thu, 14 Mar 2024 13:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Documentation: networking: document CAN ISO-TP
Content-Language: en-US
To: Francesco Valla <valla.francesco@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: fabio@redaril.me, linux-can@vger.kernel.org
References: <20240313223445.87170-1-valla.francesco@gmail.com>
 <20240313223445.87170-2-valla.francesco@gmail.com>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240313223445.87170-2-valla.francesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

-- (reduced the distribution list to Linux-CAN relevant receivers)

Hello Francesco,

many thanks for your contribution!

Additionally to the editorial remarks from Marc I would like to add some 
technical feedback.

On 2024-03-13 23:34, Francesco Valla wrote:
> Document basic concepts, APIs and behaviour of the CAN ISO-TP (ISO
> 15765-2) stack.
> 
> Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
> ---
>   Documentation/networking/index.rst |   1 +
>   Documentation/networking/isotp.rst | 347 +++++++++++++++++++++++++++++
>   2 files changed, 348 insertions(+)
>   create mode 100644 Documentation/networking/isotp.rst
> 
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index 473d72c36d61..ba22acfae389 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -19,6 +19,7 @@ Contents:
>      caif/index
>      ethtool-netlink
>      ieee802154
> +   isotp

I'm not sure whether to name this file "iso15765-2" instead of just 
"isotp". IIRC there are some more transport protocols inside the ISO 
universe.

>      j1939
>      kapi
>      msg_zerocopy
> diff --git a/Documentation/networking/isotp.rst b/Documentation/networking/isotp.rst
> new file mode 100644
> index 000000000000..d0c49fd1f5c9
> --- /dev/null
> +++ b/Documentation/networking/isotp.rst
> @@ -0,0 +1,347 @@
> +.. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +
> +====================
> +ISO-TP (ISO 15765-2) Transport Protocol

ISO 15765-2:2016

> +====================
> +
> +Overview
> +=========================
> +
> +ISO-TP, also known as ISO 15765-2 from the ISO standard it is defined in, is a

CAN ISO-TP , also known as ISO 15765-2:2016 ...

> +transport protocol specifically defined for diagnostic communication on CAN.
> +It is widely used in the automotive industry, for example as the transport
> +protocol for UDSonCAN (ISO 14229-3) or emission-related diagnostic services
> +(ISO 15031-5).
> +
> +ISO-TP can be used both on classical (2.0B) CAN and CAN-FD based networks.

CAN CC (aka Classical CAN, CAN 2.0B) and CAN FD (CAN with Flexible Datarate)

> +It is also designed to be compatible with a CAN network using SAE J1939 as data
> +link layer (however, this is not a requirement).
> +
> +Addressing
> +----------
> +
> +In its simplest form, ISO-TP is based on two kinds of addresses for the nodes

two kinds of addressing-modes

> +connected to the same network:
> +
> +- a physical address, which identifies a single node and is used in 1-to-1
> +  communication

physical addressing is implemented by two node-specific addresses (CAN 
identifiers) and is used ...

> +- a functional addess, which identifies a group of nodes and is used in 1-to-N
> +  communication

functional addressing is implemented by one node-specific address (CAN 
identifier) and is used ...

> +
> +In a so-called "normal" addressing scenario, both these addresses are
> +represented by a single byte

No. The normal addressing always needs two CAN IDs (assigned to two 
different CAN nodes) or you have functional addressing which needs only 
the sender CAN ID for the 1:N unconfirmed transmission.

  and can be inserted inside the 29-bit version of
> +the CAN ID. 


> However, in order to support larger networks, an "extended"
> +addressing scheme can be adopted; in this case, the first byte of the data
> +payload is used as an additional component of the address (both for the
> +physical and functional cases).

Yes. This is called extended addressing.

It still needs the normal addressing scheme with the one or two CAN IDs.

> +
> +Transport protocol and associated frame types
> +---------------------------------------------
> +
> +When transmitting data using the ISO-TP protocol, the payload can either fit
> +inside one single CAN message or not, also considering the overhead the protocol
> +is generating and the optional extended addressing. In the first case, the data
> +is transmitted at once using a so-called Single Frame (SF). In the second case,
> +ISO-TP defines a multi-frame protocol, in which the sender asks (through a First

... in which the sender provided the PDU length which is to be 
transmitted and also asks for a Flow Control frame which provides the 
blocksize and stmin stuff

> +Frame - FF) to the receiver the maximum supported size of a macro data block
> +(``blocksize``) and the minimum time time between the single CAN messages
> +composing such block (``stmin``). Once these informations have been received,
> +the sender starts to send frames containing fragments of the data payload
> +(called Consecutive Frames - CF), stopping after every ``blocksize``-sized block
> +to wait confirmation from the receiver (which should then send a Flow Control
> +frame - FC - to inform the sender about its availability to receive more data).
> +
> +Specifications used
> +-------------------
> +
> +* ISO 15765-2 : Road vehicles - Diagnostic communication over Controller Area
ISO 15765-2:2016

> +  Network (DoCAN). Part 2: Transport protocol and network layer services.
> +
> +How to Use ISO-TP
> +=================
> +
> +As with others CAN protocols, the ISO-TP stack support is built as a variant of
> +the SocketCAN communication, and thus uses the socket APIs.

As with others CAN protocols, the ISO-TP stack support is built into the 
Linux network subsystem for the CAN bus, aka. Linux-CAN or SocketCAN and 
thus follows the same socket API.

> +
> +Creation and basic usage of an ISO-TP socket
> +--------------------------------------------
> +
> +To use the ISO-TP stack, ``#include <linux/can/isotp.h>`` shall be used. A
> +socket can then be created using the ``PF_CAN`` protocol family, the
> +``SOCK_DGRAM`` type (as the underlying protocol is datagram-based by design)
> +and the ``CAN_ISOTP`` protocol:
> +
> +.. code-block:: C
> +
> +    s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
> +
> +After the socket has been successfully created, ``bind(2)`` shall be called to
> +bind the socket to the desired CAN interface, either:
> +
> +* specifying at least one RX or TX address, as part of the sockaddr supplied
> +  to the call itself, or
> +* after specifying broadcast flags through socket option (explained below)

You always need at least ONE CAN ID for sending (tx_id).

When you do not use the broadcasting modes CAN_ISOTP_SF_BROADCAST nor 
CAN_ISOTP_CF_BROADCAST you need the rx_id (for receiving the FC) too.

> +
> +Once bound to an interface, the socket can be read from and written to using
> +the usual ``read(2)`` and ``write(2)`` system calls, as well as ``send(2)``,
> +``sendmsg(2)``, ``recv(2)`` and ``recvmsg(2)``.
> +Unlike raw SocketCAN sockets, only the data payload shall be specified in all

Unlike the CAN_RAW socket API ...

> +these calls, as the CAN header is automatically filled by the ISO-TP stack
> +using information supplied during socket creation. In the same way, the stack
> +will use the transport mechanism when required (i.e., when the size of the data
> +payload exceeds the MTU of the underlying CAN bus).
> +
> +The sockaddr structure used for SocketCAN has extensions for use with ISO-TP,
> +as specified below:
> +
> +.. code-block:: C
> +
> +    struct sockaddr_can {
> +        sa_family_t can_family;
> +        int         can_ifindex;
> +        union {
> +            struct { canid_t rx_id, tx_id; } tp;
> +        ...
> +        } can_addr;
> +    }
> +
> +* ``can_family`` and ``can_ifindex`` serve the same purpose as for other
> +  SocketCAN sockets.
> +
> +* ``can_addr.tp.rx_id`` specifies the receive (RX) CAN ID and will be used as
> +  a RX filter.
> +
> +* ``can_addr.tp.tx_id`` specifies the transmit (TX) CAN ID
> +
> +ISO-TP socket options
> +---------------------
> +
> +When creating an ISO-TP socket, reasonable defaults are set. Some options can
> +be modified with ``setsockopt(2)`` and/or read back with ``getsockopt(2)``.
> +
> +General options
> +~~~~~~~~~~~~~~~
> +
> +General socket options can be passed using the ``CAN_ISOTP_OPTS`` optname:
> +
> +.. code-block:: C
> +
> +    struct can_isotp_options opts;
> +    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_OPTS, &opts, sizeof(opts))
> +
> +where the ``can_isotp_options`` structure has the following contents:
> +
> +.. code-block:: C
> +
> +    struct can_isotp_options {
> +        u32 flags;
> +        u32 frame_txtime;
> +        u8  ext_address;
> +        u8  txpad_content;
> +        u8  rxpad_content;
> +        u8  rx_ext_address;
> +    };
> +
> +* ``flags``: modifiers to be applied to the default behaviour of the ISO-TP
> +  stack. Following flags are available:
> +
> +  - ``CAN_ISOTP_LISTEN_MODE``: listen only (do not send FC frames)
a testing feature

> +  - ``CAN_ISOTP_EXTEND_ADDR``: enable extended addressing, using the byte
> +    specified in ``ext_address`` as additional address byte.
> +  - ``CAN_ISOTP_TX_PADDING``: enable padding for tranmsitted frames, using
> +    ``txpad_content`` as value for the padding bytes.
> +  - ``CAN_ISOTP_RX_PADDING``: enable padding for the received frames, using
> +    ``rxpad_content`` as value for the padding bytes.
> +  - ``CAN_ISOTP_CHK_PAD_LEN``: check for correct padding length on the received
> +    frames.
> +  - ``CAN_ISOTP_CHK_PAD_DATA``: check padding bytes on the received frames
> +    against ``rxpad_content``; if ``CAN_ISOTP_RX_PADDING`` is not specified,
> +    this flag is ignored.
> +  - ``CAN_ISOTP_HALF_DUPLEX``: force ISO-TP socket in half duples mode
> +    (that is, transport mechanism can only be incoming or outgoing at the same
> +    time, not both)
> +  - ``CAN_ISOTP_FORCE_TXSTMIN``: ignore stmin from received FC
a testing feature

> +  - ``CAN_ISOTP_FORCE_RXSTMIN``: ignore CFs depending on rx stmin
a testing feature

> +  - ``CAN_ISOTP_RX_EXT_ADDR``: use ``rx_ext_address`` instead of ``ext_address``
> +    as extended addressing byte on the reception path.
> +  - ``CAN_ISOTP_WAIT_TX_DONE``: wait until the frame is sent before returning
> +    from ``write(2)`` and ``send(2)`` calls (i.e., blocking write operations).
> +  - ``CAN_ISOTP_SF_BROADCAST``: use 1-to-N functional addressing (cannot be
> +    specified alongside ``CAN_ISOTP_CF_BROADCAST``)
> +  - ``CAN_ISOTP_CF_BROADCAST``: use 1-to-N transmission without flow control
> +    (cannot be specified alongside ``CAN_ISOTP_SF_BROADCAST``)
Btw. this mode is not covered by the ISO 15765-2 standard yet.

> +  - ``CAN_ISOTP_DYN_FC_PARMS``: enable dynamic update of flow control parameters
> +
> +* ``frame_txtime``: frame transmission time (defined as N_As/N_Ar inside the
> +  ISO standard); if ``0``, the default (or the last set value) is used.
> +  To set the transmission time to ``0``, the ``CAN_ISOTP_FRAME_TXTIME_ZERO``
> +  macro (equal to 0xFFFFFFFF) shall be used.
> +
> +* ``ext_address``: extended addressing byte, used if the
> +  ``CAN_ISOTP_EXTEND_ADDR`` flag is specified.
> +
> +* ``txpad_content``: byte used as padding value for transmitted frames
> +
> +* ``rxpad_content``: byte used as padding value for received frames
> +
> +* ``rx_ext_address``: extended addressing byte for the reception path, used if
> +  the ``CAN_ISOTP_RX_EXT_ADDR`` flag is specified.
> +
> +Flow Control options
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Flow Control (FC) options can be passed using the ``CAN_ISOTP_RECV_FC`` optname:

to provide the communication parameters for receiving ISO-TP PDUs.

> +
> +.. code-block:: C
> +
> +    struct can_isotp_fc_options fc_opts;
> +    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RECV_FC, &fc_opts, sizeof(fc_opts));
> +
> +where the ``can_isotp_fc_options`` structure has the following contents:
> +
> +.. code-block:: C
> +
> +    struct can_isotp_options {
> +        u8 bs;
> +        u8 stmin;
> +        u8 wftmax;
> +    };
> +
> +* ``bs``: blocksize provided in flow control frames.
> +
> +* ``stmin``: minimum separation time provided in flow control frames; can
> +  have the following values (others are reserved):
> +  - 0x00 - 0x7F : 0 - 127 ms
> +  - 0xF1 - 0xF9 : 100 us - 900 us
> +
> +* ``wftmax``: maximum number of wait frames provided in flow control frames.
> +
> +Link Layer options
> +~~~~~~~~~~~~~~~~~~
> +
> +Link Layer (LL) options can be passed using the ``CAN_ISOTP_LL_OPTS`` optname:
> +
> +.. code-block:: C
> +
> +    struct can_isotp_ll_options ll_opts;
> +    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_LL_OPTS, &ll_opts, sizeof(ll_opts));
> +
> +where the ``can_isotp_ll_options`` structure has the following contents:
> +
> +.. code-block:: C
> +
> +    struct can_isotp_ll_options {
> +        u8 mtu;
> +        u8 tx_dl;
> +        u8 tx_flags;
> +    };
> +
> +* ``mtu``: generated and accepted CAN frame type, can be equal to ``CAN_MTU``
> +  for classical CAN frames or ``CANFD_MTU`` for CAN FD frames.
> +
> +* ``tx_dl``: maximum payload length for transmitted frames, can have one value
> +  among: 8, 12, 16, 20, 24, 32, 48, 64.

Values above 8 only apply to CAN FD traffic (mtu = CANFD_MTU).

> +
> +* ``tx_flags``: flags set set into ``struct canfd_frame.flags`` at frame
> +  creation.

Only applies to CAN FD traffic (mtu = CANFD_MTU).

> +
> +Transmission stmin
> +~~~~~~~~~~~~~~~~~~
> +
> +The transmission minimum separaton time (stmin) can be forced using the
> +``CAN_ISOTP_TX_STMIN`` optname and providing an stmin value in microseconds as
> +a 32bit unsigned integer; this will overwrite the value sent by the receiver in
> +flow control frames:
> +
> +.. code-block:: C
> +
> +    uint32_t stmin;
> +    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_TX_STMIN, &stmin, sizeof(stmin));
> +
> +Reception stmin
> +~~~~~~~~~~~~~~~
> +
> +The reception minimum separaton time (stmin) can be forced using the
> +``CAN_ISOTP_RX_STMIN`` optname and providing an stmin value in microseconds as
> +a 32bit unsigned integer; received Consecutive Frames (CF) which timestamps
> +differ less than this value will be ignored:
> +
> +.. code-block:: C
> +
> +    uint32_t stmin;
> +    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &stmin, sizeof(stmin));
> +
> +Multi-frame transport support
> +--------------------------
> +
> +The ISO-TP stack contained inside the Linux kernel supports the multi-frame
> +transport mechanism defined by the standard, with the following contraints:
> +
> +* the maximum size of a PDU is defined by a module parameter, with an hard
> +  limit imposed at build time
> +* when a transmission is in progress, subsequent calls to ``write(2)`` will
> +  block, while calls to ``send(2)`` will either block or fail depending on the
> +  presence of the ``MSG_DONTWAIT`` flag
> +* no support is present for sending "wait frames": wheter a PDU can be fully
> +  received or not is decided when the First Frame is received
> +
> +Errors
> +------
> +
> +Following errors are reported to userspace:
> +
> +RX path errors
> +~~~~~~~~~~~~~~
> +
> +============ =================================================================
> +-ETIMEDOUT   timeout of data reception
> +-EILSEQ      sequence number mismatch during a multi-frame reception
> +-EBADMSG     data reception with wrong padding
> +============ =================================================================
> +
> +TX path errors
> +~~~~~~~~~~~~~~
> +
> +========== =================================================================
> +-ECOMM     flow control reception timeout
> +-EMSGSIZE  flow control reception overflow
> +-EBADMSG   flow control reception with wrong layout/padding
> +========== =================================================================
> +
> +Examples
> +========
> +
> +Basic node example
> +------------------
> +
> +Following example implements a node using "normal" physical addressing, with
> +RX ID equal to 0x18DAF142 and a TX ID equal to 0x18DA42F1. All options are left
> +to their default.
> +
> +.. code-block:: C
> +
> +  int s;
> +  struct sockaddr_can addr;
> +  int ret;
> +
> +  s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
> +  if (s < 0)
> +      exit(1);
> +
> +  addr.can_family = AF_CAN;
> +  addr.can_ifindex = if_nametoindex("can0");
> +  addr.tp.tx_id = 0x18DA42F1;
> +  addr.tp.rx_id = 0x18DAF142;

Shouldn't this be (0x18DA42F1 | CAN_EFF_FLAG) for 29 bit IDs?

When you provide an example with 11 bit IDs (e.g. 0x700 and 0x714) you 
don't need to care about the CAN_EFF_FLAG.

> +
> +  ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
> +  if (ret < 0)
> +      exit(1);
> +
> +  // Data can now be received using read(s, ...) and sent using write(s, ...)
> +
> +Additional examples
> +-------------------
> +
> +More complete (and complex) examples can be found inside the ``isotp*`` userland
> +tools, distributed as part of the ``can-utils`` utilities at:
> +https://github.com/linux-can/can-utils

Many thanks,
Oliver

