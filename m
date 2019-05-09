Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E3718633
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2019 09:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfEIH2I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 May 2019 03:28:08 -0400
Received: from first.geanix.com ([116.203.34.67]:51776 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfEIH2I (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 9 May 2019 03:28:08 -0400
Received: from [10.0.0.125] (unknown [85.184.147.232])
        by first.geanix.com (Postfix) with ESMTPSA id A101EA74;
        Thu,  9 May 2019 07:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557386837; bh=l+JF70XbYrhnGfebqs8OkBVkX+0Q1uy1LPuxICrDTU8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=L6pq3AfdKOzpSpS9WyizKfefsv93eVdZtVkfdCEkvBpfeCb7mwJlPgh+Jtcx95L6j
         o4uabV8T/FH29JoRqd0AccXtf+/p/7vtA83etyhgEO2frB6i8y1b/Ivv30v3q0DvTJ
         nSnp/kA1KXWtLQERoTn2oexqKb8a07oTGQ/0I2gzxBoHHL5Oq5YyWCIO5wkKV6XCU1
         lnWqykmev9c/X0bY9/SknfHPdeLuOHs+GbDYTmYSbU1mZuZqrz8YhcZAxL86EVUJMg
         3Uff07QQ6RECoWrTjHXLGp4LvX1RZrrD1MCVZdAcBK5GOb16AIF128r9TQLRuFJkCy
         w+aK2AvQ46GSQ==
Subject: Re: [PATCH 1/2] can: mcp251x: add support for mcp25625
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org
References: <20190507093437.26025-1-sean@geanix.com>
 <18a26b2f-5166-2142-4b8d-59818ac6fd8b@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <d6d3ae60-f457-989a-ca6c-028b75d9d115@geanix.com>
Date:   Thu, 9 May 2019 09:27:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <18a26b2f-5166-2142-4b8d-59818ac6fd8b@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 9cf0eadf640b
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 08/05/2019 14.45, Marc Kleine-Budde wrote:
> On 5/7/19 11:34 AM, Sean Nyekjaer wrote:
>> Fully compatible with mcp2515, the mcp25625 have
>> integrated transceiver.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> 
> I've mentioned the mcp25625 to the .in file and properly introduced the
> mcp25625 as a new model in the driver itself. This way the debug output
> is formated properly:
> 
>> 	netdev_info(net, "MCP%x successfully initialized.\n", priv->model);
> 
> This is how the patch looks like now:
> 

Thanks looks good :-)
/Sean





