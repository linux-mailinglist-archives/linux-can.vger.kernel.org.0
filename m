Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E310395D9A
	for <lists+linux-can@lfdr.de>; Tue, 20 Aug 2019 13:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfHTLlP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Aug 2019 07:41:15 -0400
Received: from first.geanix.com ([116.203.34.67]:40996 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbfHTLlO (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Aug 2019 07:41:14 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 76D9A27D;
        Tue, 20 Aug 2019 11:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1566301268; bh=iVrGXjBH3xlzpvnHulrRUwirM3yzC6ts0+gAQcN9Twc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KTsfTie8hhBmC0BayArQ5VsBZe9Ag99ybSwk3ClGbBAhJPpXQr7ErrlxJLk1/LlYJ
         5pPeKb5NLfjucQd9QKV+ouBYNPCDkiVcsv/Rmfk+jnfrhueJdJMMAYovnwWhB+RJXd
         fnnWKekhfyHI9wi3Z1whKjCb9p1I1iaQqrmYnvHU0Ih6TkgSKz+2irDBip4ydZ50dY
         Nx0LAZDLQq8TnfBDqxOcXKn72iT6aA6MMDhw7OrJk4uRvoBrCdLzWaROU6rJwZpnlw
         jyO4u+g5QOnJiIAk/gUzs06sGOrkmkgh3SANuE7ZpfzdSJrFBLfjMWKIchecY24qjv
         ssyKmVgGDfJ4g==
Subject: Re: [PATCH 0/9] can: mcp251x: cleanups + fix various problems
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     t.schluessler@krause.de, shc_work@mail.ru
References: <20190819153818.29293-1-mkl@pengutronix.de>
 <52d24cdb-6c88-901e-a78b-b7f16dffeec9@geanix.com>
 <fbfdf46b-e0b0-07c0-7639-ca0418cf7c2d@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <23407a19-27b4-1c26-747b-9c37f87a2c9b@geanix.com>
Date:   Tue, 20 Aug 2019 13:40:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fbfdf46b-e0b0-07c0-7639-ca0418cf7c2d@pengutronix.de>
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



On 20/08/2019 13.37, Marc Kleine-Budde wrote:
> On 8/20/19 9:10 AM, Sean Nyekjaer wrote:
> [...]
>>> Feel free to test the patches.
> 
> Thanks for testing!
> 
>> While we are at it, could we remove the platform definition section in
>> the header?
> 
> Do you mean "struct mcp251x_platform_data"?
> 
> No, that's not possible, as it's still used in the kernel:
> 
>> arch/arm/mach-pxa/icontrol.c:72:static struct mcp251x_platform_data mcp251x_info = {
>> arch/arm/mach-pxa/zeus.c:431:static struct mcp251x_platform_data zeus_mcp2515_pdata = {
> 

What I meant was the comment section in the mcp251x.c file, from line 32 
to 53. :-)

Doesn't that belong in the Documentation section?

/Sean
