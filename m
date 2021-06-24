Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1293B35FC
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 20:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhFXSsI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 14:48:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:18247 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXSsH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 14:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624560340;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=tZZ/qkHx5lWWYPIqjU/O/13N2DU3U/DshAFZSYgPobo=;
    b=PaZrH8sYh8hCGfqGOHOv7+3El+Q1umsUKgH08p3LCtX1d4BGFUNrITxtLSqLVwqMVa
    f8CqbsQ5k6kJOd1ZkDRLgpnfigKAxawLsc8FfHoTw69RexFcFs0XOKd7sKxA3xPSK8Uv
    M4OzaaQc6xz/SYwIrmkPaXAxOR2rNpBPrIv9Y8eKRHdhAeN6is/2TgMJaYHs4fyb2yG/
    7HGDMciBhaVC4djf0HAK/5wRaKtM//9cHvYcPfvsXbmISYRRW79e+HC4KATGpNuscX+P
    6YbXUBhgSI0UqlX5c9d+GdXWz0h8b5lrR3MBSBDDNmQ8sN/rOoJnzK41J3Y6futBlKtb
    Gj7g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xozF0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.27.5 DYNA|AUTH)
    with ESMTPSA id f08fc3x5OIje495
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 24 Jun 2021 20:45:40 +0200 (CEST)
Subject: Re: MSG_CONFIRM RX messages with SocketCAN known as unreliable under
 heavy load?
To:     Harald Mommer <hmo@opensynergy.com>, linux-can@vger.kernel.org
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
 <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <4b02188f-b3bd-4e80-5d1c-9ace05f54c1d@hartkopp.net>
Date:   Thu, 24 Jun 2021 20:45:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Harald,

On 24.06.21 17:21, Harald Mommer wrote:

> The device application is closed source, runs under the COQOS hypervisor 
> which is also closed source.

What is this 'device application' in the sketch below?

>> Can you sketch a quick block diagram showing guest, host, Virtio device,
>> Virtio driver, etc...
> 
> I hope this arrives on the list as is been sent and not garbled:
> 
>       Guest 2                    | Guest3
> ----------------                | ----------------
> ! cangen,      !                | ! cangen,      !
> ! candump,     !                | ! candump,     !
> ! cansend      !                | ! cansend      !
> ! using vcan0  !                | ! using can0   !
> ----------------                | ----------------
>   ^                              |             ^
>   !  ---------------------       |             !
>   !  ! Service process   !       |             !
>   !  ! in user space     !       |             !
>   !  ! virtio-can device !       |             !
>   !  ! forwarding vcan0  !       |             !
>   !  ---------------------       |             !

Hopefully not this "Service process in user space" ???

If so, this is a very questionable approach!

To route/forward/manipulate CAN frames between CAN network interfaces 
there is a CAN gateway module 'can-gw' which can be controlled over 
PF_NETLINK.

The can-gw runs super efficient and fast inside kernel space in the 
SOFTIRQ context.

E.g. 22.000 CAN frames/s with 6% sys load on a 2 core i7 from 2012, 
here: https://youtu.be/O3eOjfTl1yk?t=89

Just type cangw from the can-utils to get an impression of the powerful 
options.

You can even calculate E2E CRCs and XOR checksums after doing content 
mods on the fly.

>   !    ^               ^         |             !
>   !    !               !         |             !
> --------------------------------------------------
>   !    !   Device side ! kernel  | Driver side ! kernel
>   v    v               v         |             v
> ---------------- -------------- | ----------------
> ! Device Linux ! ! HV support ! | ! Driver Linux !
> !    VCan      ! !   module   ! | !  Virtio CAN  !
> !    vcan0     ! ! on device  ! | !     can0     !
> !              ! !   side     ! | !              !
> ---------------- -------------- | ----------------
>         ^               ^        |        ^
>         !               !        |        !
> --------------------------------------------------
>         !               !                 ! Hypervisor
>         v               v                 v
> --------------------------------------------------
> !                     COQOS-HV                   !
> --------------------------------------------------
> 

(..)

> can be handled. Need the command line switch anyway now to do experiments.

Now with cangw ?!? ;-)

Regards,
Oliver
