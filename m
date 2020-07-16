Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E10222B26
	for <lists+linux-can@lfdr.de>; Thu, 16 Jul 2020 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgGPSkv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 Jul 2020 14:40:51 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:36761 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgGPSku (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Jul 2020 14:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1594924848;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=D/m5WxyoryUrJdwJutuAeAxFwLin7xLD8TshwCNPStA=;
        b=AQWXkqDvo6Vy/IefjfLu2a2c09V20nB3KbwxT/oFtHl3CRI7GiyEIQrw5NMHCEsKM9
        Y4vjJb0+Z8EcsvwbJqXgNFNJ2X5JRZ3erCnUoBIkYninIvpPwQfHlYsT77VHROsxWWS7
        zawd8H7WN4Okm/Q0+/pXWK32fSxtQz2Qx5mO2CMWFodvdvVJfFoJA2p0OuPEEp8oki9e
        XmUEUWEU9wElJ0IMWkHUR72Gg/k8GoSoLSMrku+XxyYPC6AU90i9NOsa7ZfeFFvJ1e2e
        tib05EUKBIn30SxmSCwZ0r+cC4B1zfWoiwFJIxLjGyNlNBbgDYELW4eA+HpsYvy8HEJw
        pBYA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUsh9kCA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id R09ac6w6GIbhztu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 16 Jul 2020 20:37:43 +0200 (CEST)
Subject: Re: [Bug] Kernel Panic on Deletion of the network-namespace
 containing the SocketCAN interface
To:     Philipp Lehmann <leph1016@hs-karlsruhe.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "christian.sauer.w@sew-eurodrive.de" 
        <christian.sauer.w@sew-eurodrive.de>
References: <20ea6d4c00dc4d5f99cd004677280369@hs-karlsruhe.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <88fb5401-746a-5589-650d-a88fde43b122@hartkopp.net>
Date:   Thu, 16 Jul 2020 20:37:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20ea6d4c00dc4d5f99cd004677280369@hs-karlsruhe.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Philipp,

thanks for the report and its reproducer!

I assumed the interfaces - at least in the case of 'real' hardware CAN 
interfaces - to me moved back to the root name space ... well.

I'll take a look at it.

Best regards,
Oliver

On 16.07.20 18:46, Philipp Lehmann wrote:
> If a SocketCAN Interface (Tested with a PCAN-USB adapter) is moved into a network-namespace and the network namespace is deleted afterwards, without moving the device out of the namespace prior to the deletion. The device could not be found in any of the network namespaces afterwards, only a reboot of the system fixes this. If the device is instead removed from the USB-Bus without a restart, a kernel panic is the result.
> 
> 
> Output of uname -r [Linux cpc4x 5.4.0-40-generic #44-Ubuntu SMP Tue Jun 23 00:01:04 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux]
> 
> 
> The bug could be reproduced with the following steps:
> 
> 
> 1. Connect the (USB)-SocketCAN device to the host
> 
> 2. Add a new network namespace [sudo ip netns add test]
> 3. Move the CAN-interface to the network name-space [sudo ip link set dev can0 netns test]
> 4. Delete the namespace [sudo ip netns delete test]
> 5. Remove the adapter from the USB-Bus. In most cases this should result in a kernel panic
> 
