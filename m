Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5576358D8C5
	for <lists+linux-can@lfdr.de>; Tue,  9 Aug 2022 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbiHIMbv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Aug 2022 08:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242036AbiHIMbu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Aug 2022 08:31:50 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Aug 2022 05:31:48 PDT
Received: from mailrelay1-2.pub.mailoutpod1-cph3.one.com (mailrelay1-2.pub.mailoutpod1-cph3.one.com [46.30.212.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45F18B08
        for <linux-can@vger.kernel.org>; Tue,  9 Aug 2022 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=rsa1;
        h=content-transfer-encoding:content-type:to:subject:from:mime-version:date:
         message-id:from;
        bh=IHxKrbx0I4qpTf/8bCVdowqsph57xG4wHJ5zAlaYt6A=;
        b=YlzAjNtHRyPCVHqAsnJFfFefVZXT1x9CRHgpkA+gQp2i+rh1LCBTr3TAlhywKgncZxHiwiRMuQCI5
         4uHgffDB2xBE6uuyezc35sTXiM0bv963Q/7vAsm/cSAQ6KVh31fOVIJll4dH0ukH7pyVExqbYhuHwg
         BBW64l0S7ArKHKtlEPWF2TOzjTTcN7PgRowWOo5+MjXJKZrS7b5YZg0SW+a3ok0qj0eqzaDYzYjVtS
         43loUJOd8ZDCZe9wLmWDv8Dsz5sJed3TBiW9Ec6j1+Kg3kaxG+iIEo+kjPGb2x8tAxGRI0uVUIwUaN
         YZhZke8CsCGNOTMGfFjIABBxq3cDNTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=ed1;
        h=content-transfer-encoding:content-type:to:subject:from:mime-version:date:
         message-id:from;
        bh=IHxKrbx0I4qpTf/8bCVdowqsph57xG4wHJ5zAlaYt6A=;
        b=89itezlSCOb0BM7UlMjKbXWDs5UTagwcGN8m/kXhw9mOhIg7SMVmW8j8cd+RhBGtIm1VlGo9yU3uz
         f8hxC/ODw==
X-HalOne-Cookie: 3296973920fbe09509c93b8b6d9ae47ed3b20861
X-HalOne-ID: 16223d92-17df-11ed-a6cc-d0431ea8a283
Received: from [192.168.1.155] (unknown [5.103.118.41])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 16223d92-17df-11ed-a6cc-d0431ea8a283;
        Tue, 09 Aug 2022 12:30:43 +0000 (UTC)
Message-ID: <e396bfcd-aca2-fef8-a25d-e6e4b61e7d70@csselectronics.com>
Date:   Tue, 9 Aug 2022 14:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
From:   =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Subject: Debugging dropped/missing frames in the network layer
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I am working with an out-of-tree kernel driver which maps LIN messages 
via a UART onto the CAN networking stack, to allow for using the regular 
CAN tools to also work with LIN messages (The driver in question is 
sllin, https://github.com/lin-bus/linux-lin/, based on slcan from what I 
understand).

During use, I see a lot of frames missing from the output. From 
debugging the module, I can see that the kernel module receive the 
messages as expected, but they never show up in user space using 
candump. I can trace the messages in the module to the hand-off to the 
networking stack via a netif_rx call.

Are there any additional handles in the networking/CAN stack to show me 
where the missing frames are being discarded before reaching user space, 
or which could otherwise help me narrow down the origin of this issue? 
The frames are transmitted from a custom/third party device at 19200 
kbps and with 100 ms spacing.

Hardware on the Linux side is a Raspberry Pi 4 running kernel 5.15.56 in 
64 bit mode.

Regards, Magnus.

