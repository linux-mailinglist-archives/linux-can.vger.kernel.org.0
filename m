Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1747151DD4
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2020 17:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgBDQIJ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Feb 2020 11:08:09 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:32228 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBDQII (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2020 11:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580832487;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:Cc:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=dnmKkvklBRlUEO6cgwTlIGKbLytLLThurAQnhE5GoIs=;
        b=BdhlXBic/z4MmjRFiYcTDGHfULN9WOV4/MprRYxcr7YaEEi/uCm2C3lSxn7MVrUCaU
        VvnhgrbJQZNbCeP00UP32yArlKnfyND/+ILfQP5hBzpvY3hnS02GFQNAtMuExl31DZfl
        J1Ey+vB+VGXMIgTMvVSoyBDzfzM7ZCRerSJ2JK+vHv+DN2XLz8q3BjhDETCGEhM2OLk7
        0pZ3Z8JMelA8++yF45v0A82pLnnygiQrk+aZS4Z+XdbEzSBUtdrYkM+gTcODkNtuBp8e
        YHrHVUNYSeaicTIlVDAt5TuH7HULHZk7+U8htVEyipJpArrMH6EZwLVHiehU1w8fO9KI
        0jJA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUsh6k0go"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id g084e8w14G86D87
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 4 Feb 2020 17:08:06 +0100 (CET)
Subject: Re: Help to set up can net interface on Dell 3200 Intel Atom
To:     "Lev R. Oshvang ." <levonshe@gmail.com>
References: <CAP22eLHKe=0FEoS3DfRK8Oi6k2xntCvxQPVpXhau_bnuOAs71A@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Message-ID: <f2f20f9f-7810-e555-f6d0-11fc0510491c@hartkopp.net>
Date:   Tue, 4 Feb 2020 17:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP22eLHKe=0FEoS3DfRK8Oi6k2xntCvxQPVpXhau_bnuOAs71A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 04/02/2020 14.07, Lev R. Oshvang . wrote:

> I have with DELL 3002 Edge server
> It has can and can_raw drivers loaded at boot time
> It does not have /boot/config.txt file
> 
> Unfortunately, I do not have kernel sources and kernel config file is
> not present in /proc, so I do not know which exactly chip is on b
> oard and board specs says only:
> 
> (CAN2.0 A/B/FD) 1Mbps (CAN2.0), 5Mbps (CAN-FD).

https://topics-cdn.dell.com/pdf/dell-edge-gateway-3000-series_Specifications2_de-de.pdf
says that there is a 
https://www.microchip.com/wwwproducts/en/ATSAME70N19 Cortex-M7 which 
handles the CAN FD controller.

The ATSAME70N19 is connected somehow to the Intel Atom-Prozessor E3805.

So I won't assume, that you can access the CAN controller from the Intel 
CPU.

> I tried to set it up but get the following error
> 
> 
> root@5HCF902:~# ip link add dev can0 type can
> RTNETLINK answers: Operation not supported

You can not "add" a real CAN interface with "ip link add ..." - this 
works only for virtual CANs.

Try

ip -det link show

where some CAN interface (e.g. can0) should be visible, if you have one.

Regards,
Oliver

