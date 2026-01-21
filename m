Return-Path: <linux-can+bounces-6251-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMunEF86cWnKfQAAu9opvQ
	(envelope-from <linux-can+bounces-6251-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 21:43:11 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0F5D7E5
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 21:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAFC674DCE2
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 18:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523A5354AD6;
	Wed, 21 Jan 2026 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1mHXSwk"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18933346AC
	for <linux-can@vger.kernel.org>; Wed, 21 Jan 2026 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019881; cv=none; b=RYuDmWveo214k9mA3V6BnL2LcgjcfsrBywLeu16NuMUENUf1CQG6SFkf9DPCzVAmU+KY6k/YtpjHBzCQBwkbXX+aTefvaOFDNh8P0b35uRQ3A5TmDH9iCcdohenDfrXm4Fg1XXLxQ2KA11pLU+ou/2cDsg1RVVDOLIVhtdFHkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019881; c=relaxed/simple;
	bh=5foRD+XYdggu1Kg1ROkRGTuBP0YuzBsFR3l3Gq3NRDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxhxpynIVH5pMHly338kVUQhe+BNglMYUl/nNo86W6Hh6e5xO5dcLgqQ5MOJcU3b+/oi/94GOIJt/1wQJrgehCV+db4o56hRHDXxMR18e++CN/17Q5ua7pSeEXPD/kUDQ7kTFWFJJQIanJ9sCOG5VD+xbdwPW+77XqLCuRhx6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1mHXSwk; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso21678a12.3
        for <linux-can@vger.kernel.org>; Wed, 21 Jan 2026 10:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769019877; x=1769624677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVjRoasFG/sB0MpTfb46SvA5d7ZE0DXe29Yv2eIU8xo=;
        b=f1mHXSwkUitqLqdPf29HX/mF+s8tuVfWqQq4xfvYqwAXuxmfTb5Z+eDQAjupFIh1AN
         1ZfOXYt7R7ErqEikz31wav5AUkXZZFIqsDyVlM2lCiMwjm4hkWDEWNPf8i8Xz5tayFIe
         n61ZghaamOwO5VYB/Oy+FZAnaVkekQE7doe9PoqtdVRKrSCtnc18V00kHYIp4ut0AYb3
         ANMNQRfXiNtw8Ow6MlsYKC27T3+w1KElNdzWYxtHHy7m9aOSJJTYLitJsUSghP+PRJHl
         A18WU+gShzEAKwK0puouyKSmGDT0g7vTZewWlgLK0NTBKTKCkpWEeMqPHSv0uXQvyFdZ
         II1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769019877; x=1769624677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVjRoasFG/sB0MpTfb46SvA5d7ZE0DXe29Yv2eIU8xo=;
        b=sJ5cWPSeTCens0A1rSDEFJsbrFZPpBJcNvSU23jcXQIu708aFjRmhxc5ZhpFlY/onT
         yOqrpo+aRMuFBWi/amKOnI0NDE4gDRczBfU+uIlRYJ2pYxu39K++QI5Yh6OzDQqGccNS
         DyBxrBQa3h9kBPhaej+qbEOG7ViUI5cqlRO/tDMkPC6ibGonHSCAOXREFaShVn7LgoTh
         yEooCCQupVqFzc6LB9XJhPzx3Uk8oTX9UsxFgDVDO4dRrVYQRNJC0j6yqh/JJxGQPK5l
         jKyxrxxj2N0dYw4ahMfC7SZxmkSRsXurLxij/5WSAjwHUslqsU9Pzh+7U2u0kw7D4ted
         H10Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeEyB6hwL9ilUJizQMMHM2ec759VRIsNygASnNMZV4gZVu1b8HdUW47GtNkAxY9ArQ8dVFXzqWEt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ6SI70LPrSJde8KmPCJ1c/LuCqc7zGCN3N3Qf30Z+JXSIs08A
	iGfCf2a1sXg1vIZPE/0kYsPK832xM7EcLK6qCvPpy2vqKR8yVns8hXuR
X-Gm-Gg: AZuq6aJSVqKrB+jZdOMGfNuyZXIP5NqhZaGdkDsvj7gzZTVGcuGzZv7jIF7smEDdhZu
	uzxj+z2fvvlSesCexZhsA9xjNSRDmOy2ZQ416lrsVQolOVt2x9B6k+BrcJDvWIh3CbqL298zheC
	YDZ1GSL0iQo8Bj5D7cR61rz55xfH7udoTY747GUPlJ6OxOBUOM3JFcQSSwqXnzb1RaRauBInaNu
	yShtUBXA1Vz0dSmI+4uMIfnUJPARq9z0fNv7jducAm3xGBz6E137t2mpAS0NoLNJBABgf56jchm
	u3fRAOHe1/I4pyFfu2zX5LZlGhmNUHAmtjyxjF0/92XeD0+8jWKtwhzkNVJxmr5FkliviKxn4DE
	FpyLv1gyvmWFnMU3kadVZL+S7Cfdx4mmv/Kj8Uyzb+9U501Hy2exn/vDMeLK66xAIfbuBxPns5l
	gSYks+ocGUhJLHlUtk
X-Received: by 2002:a17:903:2f04:b0:295:20b8:e104 with SMTP id d9443c01a7336-2a7177e9c74mr156003005ad.58.1769019876742;
        Wed, 21 Jan 2026 10:24:36 -0800 (PST)
Received: from rakuram-MSI ([2405:201:d027:f80f:3dfc:481a:1cd0:e1a3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190aa340sm159511995ad.3.2026.01.21.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 10:24:36 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: socketcan@hartkopp.net
Cc: corbet@lwn.net,
	linux-can@vger.kernel.org,
	linux-doc@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	rakuram.e96@gmail.com
Subject: Re: [PATCH 2/2] docs: can: update SocketCAN documentation for CAN XL
Date: Wed, 21 Jan 2026 23:54:25 +0530
Message-ID: <20260121182429.16624-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: 6a99ce41-2200-49d7-9a6c-29e9311b46ab@hartkopp.net 
References: <6a99ce41-2200-49d7-9a6c-29e9311b46ab@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[lwn.net,vger.kernel.org,kernel.org,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6251-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rakurame96@gmail.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,hartkopp.net:email]
X-Rspamd-Queue-Id: E7C0F5D7E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 18 Jan 2026 at 23:53, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
>
> On 18.01.26 15:41, Rakuram Eswaran wrote:
> > On Tue, 13 Jan 2026 at 21:45, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> >>
>
> >>>    The length of the two CAN(FD) frame structures define the maximum transfer
> >>>    unit (MTU) of the CAN(FD) network interface and skbuff data length. Two
> >>> -definitions are specified for CAN specific MTUs in include/linux/can.h:
> >>> +definitions are specified for CAN specific MTUs in include/uapi/linux/can.h:
> >>
> >> No.
> >>   From the user perspective he has to include include/linux/can.h
> >>
> >> Better "MTUs in the linux/can.h include file:"
> >>
> >
> > Can I just incude linux/can.h or include/linux/can.h? As in the current
> > document include/linux/can.h is used.
> >
>
> If you look into the code you need e.g.
>
> #include <linux/can.h>
> #include <linux/can/raw.h>
>
> So I would name it the linux/can.h include file.
>

Hi Oliver,

Ah, now I understand what I did wrong in my interpretation. I replaced
all instances of include/linux/can.h to linux/can.h include file.

> >>
> >> What about the PWM settings here?
> >> When TMS is "on" the PWM values can be automatically calculated or set
> >> manually. There's also no CAN XL TDC when TMS=on as the TDC is a
> >> mixed-mode requirement for non-TMS transceivers.
> >>
> >
> > Can I add the PWM settings under new heading (CAN XL PWM) or is it fine
> > to keep the content under the same heading (CAN XL TDC)?
> >
>
> Yes. I would propose a new section
>
> CAN XL TMS (Transceiver Mode Setting / PWM)
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The Transceiver Mode Setting (TMS) switches the RX/TX lines between the
> CAN XL controller and the CAN XL transceiver into the "Fast Mode" by
> enabling a PWM protocol.
>
> In the Fast Mode a different sample point is used and the PWM ratio is
> calculated automatically or can be set manually.
>

Ok, will add this section. In the below article, I saw a table named
"CAN transceiver modes signaled". Can I add them here or above content
is fine?

https://www.can-cia.org/can-knowledge/can-xl

> >> There's one big difference between CC/FD and XL frames when you
> >> read/write it to CAN_RAW sockets:
> >>
> >> For CAN CC and CAN FD you write struct can(fd)_frame's with CAN_MTU
> >> resp. CANFD_MTU lengths - no matter about the data length (cf->len).
> >>
> >> When you read/write CAN XL frames you are reading and writing the
> >> CANXL_HDR_SIZE + the length of the data.
> >>
> >> So only in the case of writing 2048 byte data, you write 2060 bytes.
> >>
> >> The minimum size for read/write is CANXL_HDR_SIZE + CANXL_MIN_DLEN == 13
> >>
> >
> > Good point! I will add this information along with an example. I will go
> > through your code and decide what to add. Does the example code should
> > focus only on CAN XL frames or also on CC/FD frames?
>

Here, I added a updated content for PWM section and Application considerations
for CAN XL section.

CAN XL TMS (Transceiver Mode Setting / PWM)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Transceiver Mode Setting (TMS) switches the RX/TX lines between the
CAN XL controller and the CAN SIC XL transceiver into the "Fast Mode" by
enabling a PWM protocol.

In the Fast Mode, a different sample point is used and the PWM ratio is
either calculated automatically or can be set manually.

Application considerations for CAN XL
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For user space applications the following rules are important when
handling CAN XL:

- Use ``struct canxl_frame`` as basic data structure when CAN XL traffic
  is expected.
- Set CANXL_XLF in ``canxl_frame.flags`` for all valid CAN XL frames.
- Ensure that undefined bits in ``canxl_frame.flags`` are kept at zero.
- Respect the configured device MTU; do not send frames larger than
  the MTU announced by the kernel.
- For mixed-mode controllers, be prepared to handle Classical CAN,
  CAN FD and CAN XL frames on the same interface and choose the frame
  structure according to the socket/protocol semantics (e.g. dedicated
  CAN XL APIs when available).
- There's one big difference between CC/FD and XL frames when you
  read/write it to CAN_RAW sockets:
    - For CAN CC and CAN FD, struct can(fd)_frame's with CAN_MTU/CANFD_MTU
      lengths.
    - Read/write of CAN XL frames you are reading and writing the
      CANXL_HDR_SIZE + the length of the data.
    - The minimum size for read/write is CANXL_HDR_SIZE + CANXL_MIN_DLEN == 13.   

> When the CAN_RAW socket enables the CAN XL support you have to deal with
> all kind of CAN frames. IMO is makes sense to show an example that deals
> with all three types of frames.
>
> >> Here is an example that I've been implemented recently that shows a good
> >> example how to handle CC/FD/XL frames, when they are all enabled on the
> >> CAN_RAW socket:
> >>
> >> https://github.com/hartkopp/can-utils/commit/bf0cae218af9b1c1f5eabad7f3704b88ab642e00
> >>
> >> Feel free to pick the code for some example.
> >>
> >> But please do not reference the commit as it is in my private repo and
> >> not yet integrated in the official can-utils repo.
> >>

I had gone through the code and picked the below code for example. I add the
code here. Kindly let me know if I need to add anything extra. 

/* CAN CC/FD/XL frame union */
union cfu {
	struct can_frame cc;
	struct canfd_frame fd;
	struct canxl_frame xl;
};

struct sockaddr_can addr;
static union cfu cu;

// open CAN_RAW socket
s = socket(PF_CAN, SOCK_RAW, CAN_RAW);

/* try to switch the socket into CAN FD mode */
setsockopt(s, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &canfx_on, sizeof(canfx_on));
setsockopt(s, SOL_CAN_RAW, CAN_RAW_XL_FRAMES, &canfx_on, sizeof(canfx_on));
/* try to enable the CAN XL VCID pass through mode */
setsockopt(s, SOL_CAN_RAW, CAN_RAW_XL_VCID_OPTS, &vcid_opts, sizeof(vcid_opts));

addr.can_family = AF_CAN;

// create the sockaddr binding
if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		perror("bind");
		return 1;
	}

// The minimum size for read/write is CANXL_HDR_SIZE + CANXL_MIN_DLEN == 13 bytes 
// (12 bytes of header + minimum 1 byte data)
if (cu.xl.flags & CANXL_XLF) {
    if (nbytes != (int)CANXL_HDR_SIZE + cu.xl.len) {
        printf("nbytes = %d\n", nbytes);
        fprintf(stderr, "read: no CAN XL frame\n");
        return 1;
    }
    rx_id = cu.xl.prio & CANXL_PRIO_MASK; /* remove VCID value */
    data = cu.xl.data;
    framelen = cu.xl.len;
} else {
    /* mark dual-use struct canfd_frame */
    if (nbytes == CAN_MTU)
        cu.fd.flags = 0;
    else if (nbytes == CANFD_MTU)
        cu.fd.flags |= CANFD_FDF;
    else {
        fprintf(stderr, "read: incomplete CAN CC/FD frame\n");
        return 1;
    }
    rx_id = cu.fd.can_id;
    data = cu.fd.data;
    framelen = cu.fd.len;
}

>
> Best regards,
> Oliver
>

Best Regards,
Rakuram.

