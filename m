Return-Path: <linux-can+bounces-393-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 474CE87C539
	for <lists+linux-can@lfdr.de>; Thu, 14 Mar 2024 23:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 287BFB21920
	for <lists+linux-can@lfdr.de>; Thu, 14 Mar 2024 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAFF6127;
	Thu, 14 Mar 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeLkuOFj"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6D5677
	for <linux-can@vger.kernel.org>; Thu, 14 Mar 2024 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455896; cv=none; b=A1qHcx2rFXJdTW+g7/oTjxNsURwDL8I1hg6TbI/CvUUjcvtCwRwPbU8Wp8wVK5vU6e0DvapCYFj6CRrw+CTLz0QQXOH1Avlb3k23ISYrRBPeBPfd3fhB2MWHjlP9iAHGb0Y+bU9/5bxo84D/SB6tJUNJlp87BKBl9b9CaiSNekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455896; c=relaxed/simple;
	bh=X3Y9iRsGZB3ubKvlF07XUF4yYJDHjyEO+BDIeijqtCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+lwO9LfE/O0h1NOHpoEJuIgMaN4q30K5mkKC+cGAGBxrIYAYAOp+qIz9hEGemXsHYw8w5uUS5Hrm51+VCc88BXq74RpLfPnni+URWCPweqvuNQuZtHSiKfGUVG5qgUTcln9alMbC/rQGvhHkmqUHHMl4P2nD2D45Qk1w7UH95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeLkuOFj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so20929171fa.3
        for <linux-can@vger.kernel.org>; Thu, 14 Mar 2024 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710455892; x=1711060692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXGvFRa20gvUPGecb8AEoILT8FWqSA+//ji948Y2Vos=;
        b=CeLkuOFj0kEkZHqJJzjsePuf6RCH7qkmNWGw1tZ2QzcYzr4nkoE1LdoDiV9AXKRybm
         kz97bCq6hoo79MGqU2E/+KKhgHyLDrTWrdH+umKBcK0Vz3rsS3nPkvASw0ztBbiqxTyT
         9rxKyFz8JTPABuV3bLjuyxJe8rF97IKtZQRPSGZCGTSqmYD3Pj6wCJUaL+HObGQwpdJr
         pXvKZ4gpgUNvQ/YBKN3VqHYkmkmtm/v8un0HcJUaK7wNJgdG8fsVi51hBiT/q/R3nOvE
         PCmadHQ+Ej3m16duJ6lcVTASRAqVxNPddNAWXavsPRJX2GuYtW9tfrCJUz5Htk1+AmNe
         /3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710455892; x=1711060692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXGvFRa20gvUPGecb8AEoILT8FWqSA+//ji948Y2Vos=;
        b=hP2MP0hh0tkAj9MomdXXx+bpHQvn7P/Q818iJ/wNRYq+GmviW+2V4qEtDlUhXZPqnL
         H+W60EYm/BbpgjXbkaDOv9ZuUpKhFu6hK5iDdFFqE98v/4kCU1ur74yu5K03F+pHpFoG
         hB+zGH9ohmi0oAdPAXoxG+Aj9mx4ZJBnGkhb2ccDAsh/NUvEqlceceX/n14+5pVEfKEH
         0cGswKvz7bKWenTAtlrvzB1floApzanmnlncbTWPuCRt0/TcFAhsy1OF5fb7WpDTf5SP
         06JdO6rkWuStlUEO2joWULgEM9TsvMXMYzFM87NHxtKU7zYlSI9jrzCyrUwMzJyWo4l+
         Qb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6020EZXcMLuMjplGEiqs3okVPROXbJbR2kfxBtxTQ1P2ftZSyz//Eykr55Q3z40XWou2hVWxNT2sTaPy7RA45E+/ymsMCDvJz
X-Gm-Message-State: AOJu0YxErrFqRYxwKVBK0uRZUVzNEDusgphB5hTysmlYl3yQrIhZ3SUy
	UpHyuqgIAEzIzFkixV813LNc7FZMD4y5SMyvHmwXVSeSxdfCOBUx2CXs0vEjilzb0w==
X-Google-Smtp-Source: AGHT+IEkt1ZqshivGX24fTmag6oEG3qMuc1a51xr/0eBnKuZTWeaB8NpK+r7Leeu67H1dcgRovDT9Q==
X-Received: by 2002:a2e:350d:0:b0:2d3:a7da:b17b with SMTP id z13-20020a2e350d000000b002d3a7dab17bmr1152231ljz.4.1710455892088;
        Thu, 14 Mar 2024 15:38:12 -0700 (PDT)
Received: from fedora (host-95-250-206-50.retail.telecomitalia.it. [95.250.206.50])
        by smtp.gmail.com with ESMTPSA id qh9-20020a170906eca900b00a45380dfd09sm1095602ejb.105.2024.03.14.15.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 15:38:11 -0700 (PDT)
Date: Thu, 14 Mar 2024 23:38:09 +0100
From: Francesco Valla <valla.francesco@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, fabio@redaril.me,
	linux-can@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: networking: document CAN ISO-TP
Message-ID: <ZfN8UaCEACisoJ4u@fedora>
References: <20240313223445.87170-1-valla.francesco@gmail.com>
 <20240313223445.87170-2-valla.francesco@gmail.com>
 <a8d158dc-0488-491a-bf68-64e984d9a7fa@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d158dc-0488-491a-bf68-64e984d9a7fa@hartkopp.net>

Hi Oliver,

On Thu, Mar 14, 2024 at 01:59:50PM +0100, Oliver Hartkopp wrote:
> > diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> > index 473d72c36d61..ba22acfae389 100644
> > --- a/Documentation/networking/index.rst
> > +++ b/Documentation/networking/index.rst
> > @@ -19,6 +19,7 @@ Contents:
> >      caif/index
> >      ethtool-netlink
> >      ieee802154
> > +   isotp
> 
> I'm not sure whether to name this file "iso15765-2" instead of just "isotp".
> IIRC there are some more transport protocols inside the ISO universe.
>

This was my doubt as well, I decided to name it "isotp" to be aligned
with the source file that contains the implementation. But I can rename
it if you think is better / more understandable.

There are for sure other ISO protocols implementing a transport - first
that comes to my mind is the transport part inside ISO11783/ISOBUS.

> > +====================
> > +ISO-TP (ISO 15765-2) Transport Protocol
> 
> ISO 15765-2:2016
>

Noted.

> > +====================
> > +
> > +Overview
> > +=========================
> > +
> > +ISO-TP, also known as ISO 15765-2 from the ISO standard it is defined in, is a
> 
> CAN ISO-TP , also known as ISO 15765-2:2016 ...
>

Noted, as before.

> > +transport protocol specifically defined for diagnostic communication on CAN.
> > +It is widely used in the automotive industry, for example as the transport
> > +protocol for UDSonCAN (ISO 14229-3) or emission-related diagnostic services
> > +(ISO 15031-5).
> > +
> > +ISO-TP can be used both on classical (2.0B) CAN and CAN-FD based networks.
> 
> CAN CC (aka Classical CAN, CAN 2.0B) and CAN FD (CAN with Flexible Datarate)
> 

Ok

> > +It is also designed to be compatible with a CAN network using SAE J1939 as data
> > +link layer (however, this is not a requirement).
> > +
> > +Addressing
> > +----------
> > +
> > +In its simplest form, ISO-TP is based on two kinds of addresses for the nodes
> 
> two kinds of addressing-modes
>

Ok

> > +connected to the same network:
> > +
> > +- a physical address, which identifies a single node and is used in 1-to-1
> > +  communication
> 
> physical addressing is implemented by two node-specific addresses (CAN
> identifiers) and is used ...
> 

(see below)

> > +- a functional addess, which identifies a group of nodes and is used in 1-to-N
> > +  communication
> 
> functional addressing is implemented by one node-specific address (CAN
> identifier) and is used ...
>

(see below)

> > +
> > +In a so-called "normal" addressing scenario, both these addresses are
> > +represented by a single byte
> 
> No. The normal addressing always needs two CAN IDs (assigned to two
> different CAN nodes) or you have functional addressing which needs only the
> sender CAN ID for the 1:N unconfirmed transmission.
>

Here I was referring to the N_TA address defined by the standard, which is
defined as 8 bits long and can identify either one single node (in
physical addressing) or a group of nodes (in functional addressing). But
from the point of view of a user and not a network planner referring to
CAN IDs is probably a better approach.

> 
> 
> > However, in order to support larger networks, an "extended"
> > +addressing scheme can be adopted; in this case, the first byte of the data
> > +payload is used as an additional component of the address (both for the
> > +physical and functional cases).
> 
> Yes. This is called extended addressing.
> 
> It still needs the normal addressing scheme with the one or two CAN IDs.
>

I'll add this note to the description of the extended addressing.

> > +
> > +Transport protocol and associated frame types
> > +---------------------------------------------
> > +
> > +When transmitting data using the ISO-TP protocol, the payload can either fit
> > +inside one single CAN message or not, also considering the overhead the protocol
> > +is generating and the optional extended addressing. In the first case, the data
> > +is transmitted at once using a so-called Single Frame (SF). In the second case,
> > +ISO-TP defines a multi-frame protocol, in which the sender asks (through a First
> 
> ... in which the sender provided the PDU length which is to be transmitted
> and also asks for a Flow Control frame which provides the blocksize and
> stmin stuff
>

Ok

> > +
> > +Specifications used
> > +-------------------
> > +
> > +* ISO 15765-2 : Road vehicles - Diagnostic communication over Controller Area
> ISO 15765-2:2016
>

Noted

> > +
> > +How to Use ISO-TP
> > +=================
> > +
> > +As with others CAN protocols, the ISO-TP stack support is built as a variant of
> > +the SocketCAN communication, and thus uses the socket APIs.
> 
> As with others CAN protocols, the ISO-TP stack support is built into the
> Linux network subsystem for the CAN bus, aka. Linux-CAN or SocketCAN and
> thus follows the same socket API.
>

Ok

> > +After the socket has been successfully created, ``bind(2)`` shall be called to
> > +bind the socket to the desired CAN interface, either:
> > +
> > +* specifying at least one RX or TX address, as part of the sockaddr supplied
> > +  to the call itself, or
> > +* after specifying broadcast flags through socket option (explained below)
> 
> You always need at least ONE CAN ID for sending (tx_id).
> 
> When you do not use the broadcasting modes CAN_ISOTP_SF_BROADCAST nor
> CAN_ISOTP_CF_BROADCAST you need the rx_id (for receiving the FC) too.
>

Couldn't listen-only mode be used without specifying a tx_id?

Nevertheless, I'll reword "address" as "CAN ID".

> > +
> > +Once bound to an interface, the socket can be read from and written to using
> > +the usual ``read(2)`` and ``write(2)`` system calls, as well as ``send(2)``,
> > +``sendmsg(2)``, ``recv(2)`` and ``recvmsg(2)``.
> > +Unlike raw SocketCAN sockets, only the data payload shall be specified in all
> 
> Unlike the CAN_RAW socket API ...
>

Ok

> > +
> > +  - ``CAN_ISOTP_LISTEN_MODE``: listen only (do not send FC frames)
> a testing feature
>

I'll add "normally used as a testing feature".

> > +  - ``CAN_ISOTP_EXTEND_ADDR``: enable extended addressing, using the byte
> > +    specified in ``ext_address`` as additional address byte.
> > +  - ``CAN_ISOTP_TX_PADDING``: enable padding for tranmsitted frames, using
> > +    ``txpad_content`` as value for the padding bytes.
> > +  - ``CAN_ISOTP_RX_PADDING``: enable padding for the received frames, using
> > +    ``rxpad_content`` as value for the padding bytes.
> > +  - ``CAN_ISOTP_CHK_PAD_LEN``: check for correct padding length on the received
> > +    frames.
> > +  - ``CAN_ISOTP_CHK_PAD_DATA``: check padding bytes on the received frames
> > +    against ``rxpad_content``; if ``CAN_ISOTP_RX_PADDING`` is not specified,
> > +    this flag is ignored.
> > +  - ``CAN_ISOTP_HALF_DUPLEX``: force ISO-TP socket in half duples mode
> > +    (that is, transport mechanism can only be incoming or outgoing at the same
> > +    time, not both)
> > +  - ``CAN_ISOTP_FORCE_TXSTMIN``: ignore stmin from received FC
> a testing feature
>

(see above)

> > +  - ``CAN_ISOTP_FORCE_RXSTMIN``: ignore CFs depending on rx stmin
> a testing feature
> 

(again, see above)

> > +  - ``CAN_ISOTP_RX_EXT_ADDR``: use ``rx_ext_address`` instead of ``ext_address``
> > +    as extended addressing byte on the reception path.
> > +  - ``CAN_ISOTP_WAIT_TX_DONE``: wait until the frame is sent before returning
> > +    from ``write(2)`` and ``send(2)`` calls (i.e., blocking write operations).
> > +  - ``CAN_ISOTP_SF_BROADCAST``: use 1-to-N functional addressing (cannot be
> > +    specified alongside ``CAN_ISOTP_CF_BROADCAST``)
> > +  - ``CAN_ISOTP_CF_BROADCAST``: use 1-to-N transmission without flow control
> > +    (cannot be specified alongside ``CAN_ISOTP_SF_BROADCAST``)
> Btw. this mode is not covered by the ISO 15765-2 standard yet.
>

Good to know, I was wondering why this was introduced, as I was not
remembering it from when I read the standard a couple of years ago. Will
it be part of the next revision (which is saw is under publication)?

> > +
> > +Flow Control options
> > +~~~~~~~~~~~~~~~~~~~~
> > +
> > +Flow Control (FC) options can be passed using the ``CAN_ISOTP_RECV_FC`` optname:
> 
> to provide the communication parameters for receiving ISO-TP PDUs.
>

Ok

> > +
> > +* ``mtu``: generated and accepted CAN frame type, can be equal to ``CAN_MTU``
> > +  for classical CAN frames or ``CANFD_MTU`` for CAN FD frames.
> > +
> > +* ``tx_dl``: maximum payload length for transmitted frames, can have one value
> > +  among: 8, 12, 16, 20, 24, 32, 48, 64.
> 
> Values above 8 only apply to CAN FD traffic (mtu = CANFD_MTU).
>

Right, I'll add a note.

> > +
> > +* ``tx_flags``: flags set set into ``struct canfd_frame.flags`` at frame
> > +  creation.
> 
> Only applies to CAN FD traffic (mtu = CANFD_MTU).
>

(see above)

> > +
> > +Basic node example
> > +------------------
> > +
> > +Following example implements a node using "normal" physical addressing, with
> > +RX ID equal to 0x18DAF142 and a TX ID equal to 0x18DA42F1. All options are left
> > +to their default.
> > +
> > +.. code-block:: C
> > +
> > +  int s;
> > +  struct sockaddr_can addr;
> > +  int ret;
> > +
> > +  s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
> > +  if (s < 0)
> > +      exit(1);
> > +
> > +  addr.can_family = AF_CAN;
> > +  addr.can_ifindex = if_nametoindex("can0");
> > +  addr.tp.tx_id = 0x18DA42F1;
> > +  addr.tp.rx_id = 0x18DAF142;
> 
> Shouldn't this be (0x18DA42F1 | CAN_EFF_FLAG) for 29 bit IDs?
> 
> When you provide an example with 11 bit IDs (e.g. 0x700 and 0x714) you don't
> need to care about the CAN_EFF_FLAG.
>

Correct, I always forget the CAN_EFF_FLAG.



Thank you for the very thorough review! I'll wait for other feedbacks (if
any) and then start working on the v2.

Regards,
Francesco



