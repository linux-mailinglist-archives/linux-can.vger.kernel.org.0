Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A00E27CB0D
	for <lists+linux-can@lfdr.de>; Tue, 29 Sep 2020 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgI2MY1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 29 Sep 2020 08:24:27 -0400
Received: from mailrelay2-2.pub.mailoutpod1-cph3.one.com ([46.30.212.1]:34227
        "EHLO mailrelay2-2.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732631AbgI2MYL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2020 08:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csselectronics.com; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:date:message-id:to:
         subject:from:from;
        bh=rXnn6NQmcOZrsmVWClVmC+GgrQk/YCET9FP/ajCz558=;
        b=YH2H+d+o9L450aD5NMpeAYGSV/MxP1sPiIP0O5/Zo3S+twynUujeQ2pzHK9U1u3I4nIvt4naWxr2X
         hq5O461nWjFqfSNsSUrzShSgHhYKBGyECMMwPvdk8Naki1DfY5jFCGS44fwbzm1bCyDZX3260kpxrZ
         nr0krQPYs9dGl7ilWDcDgOpf+StsFTZp83NmL73qitZJCLM4ItA8Cr5FN4U5ADqpkr8/2rrSxaEB3v
         8I/XQWyU9MugYS/Lbxk40aozU/gZ4QaqEQjn+/U6nOB9AiAjyqLumUAVkgD1K4PmcOpvLWYVMK5/yi
         40XENHNgKgoK8ct4viVfl9n5VrjEQTA==
X-HalOne-Cookie: 71ba302a6b4e5c894ed70784b544aa818a768646
X-HalOne-ID: e825ee8d-0243-11eb-84a6-d0431ea8a290
Received: from [192.168.0.157] (unknown [5.103.118.41])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id e825ee8d-0243-11eb-84a6-d0431ea8a290;
        Tue, 29 Sep 2020 11:07:04 +0000 (UTC)
From:   =?UTF-8?Q?Magnus_Aagaard_S=c3=b8rensen?= <mas@csselectronics.com>
Subject: mcp25xxfd driver questions
To:     linux-can@vger.kernel.org
Message-ID: <f888df6e-d281-b9b6-93de-1a7329f011ed@csselectronics.com>
Date:   Tue, 29 Sep 2020 13:07:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is my first post to the list, so please inform me of any errors in 
etiquette.

I'm evaluating the MCP2518FD, and have two questions to the driver.

1. I could not find any references to the GPIOs of the chip. Is it 
correct that these are not exposed to the host system?

2. When setting the oscillator frequency outside the 
MCP25XXFD_SYSCLOCK_HZ_MIN and MCP25XXFD_SYSCLOCK_HZ_MAX range, the 
frequency is compared to the max value scaled by the max PLL value. Is 
the intention to compare with the min value? Currently, an external 
oscillator of 4 MHz and a PLL value of 10, resulting in 40 MHz, is 
treated as being too low.

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c 
b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
index bd2ba981ae36..9e0246c4e49f 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
@@ -2770,7 +2770,7 @@ static int mcp25xxfd_probe(struct spi_device *spi)
          return -ERANGE;
      }

-    if (freq <= MCP25XXFD_SYSCLOCK_HZ_MAX / MCP25XXFD_OSC_PLL_MULTIPLIER) {
+    if (freq <= MCP25XXFD_SYSCLOCK_HZ_MIN / MCP25XXFD_OSC_PLL_MULTIPLIER) {
          dev_err(&spi->dev,
              "Oscillator frequency (%u Hz) is too low and PLL is not 
supported.\n",
              freq);

Regards, Magnus.



