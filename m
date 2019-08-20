Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4C0957E6
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 09:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfHTHLQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 03:11:16 -0400
Received: from first.geanix.com ([116.203.34.67]:54514 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbfHTHLQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 03:11:16 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id A581B26D;
        Tue, 20 Aug 2019 07:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566285070; bh=iWPcjMjw+cVXoifLpYuY7POWCx6Iq1qvJezQJpHVppk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OJjTXHnJinSQp9pXGG5GgsfM3kg6YVBXK7xMjvPUYtZTFqNNw9VyuRHMTlsQoJqqd
         u3a9clJJ3zUEnukRTj8zn7URc6SypI8GRAaYUh5SxRPyJ5YwKTjO2W9eCNyOonptxG
         zcZFKEQDqULj6Nlj7oxmXifSPP1kqUX8rgkmC1UyldB+Qtm+KJ1pyv6amBiSqRC2dN
         xxyCKBz4NUs0esfU/Gvjyq9FpXZjhvmDAHXI6CHEtdpHf6c3yFNiwTOZIez/AbLfRu
         PZ+d3TAfmHMOMNELHUCT8rJG1aH9NRQY+vz8cqG8mzRH9dYJO8iBEwCUST9ISJEnZ7
         RWioF4mFZ/HAw==
Subject: Re: [PATCH 0/9] can: mcp251x: cleanups + fix various problems
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru
References: <20190819153818.29293-1-mkl@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <52d24cdb-6c88-901e-a78b-b7f16dffeec9@geanix.com>
Date:   Tue, 20 Aug 2019 09:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819153818.29293-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 19/08/2019 17.38, Marc Kleine-Budde wrote:
> Hello,
> 
> this patch series first cleans up the mcp251x driver and then fixes some
> problems found on the Raspberry Pi, like more time during HW reser and
> use of DT spplied interrupt flags. Further I've removed the custom DMA
> mapped buffers, which is handled by the SPI core fore quite some time
> now.
> 
> Feel free to test the patches.
> 
> regards,
> Marc
> 
> 
> 

While we are at it, could we remove the platform definition section in 
the header?

/Sean
