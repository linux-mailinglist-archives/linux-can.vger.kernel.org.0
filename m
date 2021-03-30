Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D248A34ED34
	for <lists+linux-can@lfdr.de>; Tue, 30 Mar 2021 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhC3QIs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 Mar 2021 12:08:48 -0400
Received: from mail.rdts.de ([195.243.153.28]:43434 "EHLO mail.rdts.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhC3QIc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 30 Mar 2021 12:08:32 -0400
Received: from webmail.rdts.de (php1.rdts.de [82.223.13.20])
        by mail.rdts.de (Postfix) with ESMTPSA id 0F2F3A60B0;
        Tue, 30 Mar 2021 18:08:30 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Mar 2021 18:08:29 +0200
From:   Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [mcp251x] Using MCP2515 with half duplex driver fails on init
In-Reply-To: <20210330100411.x4syylvj4hjprhe4@pengutronix.de>
References: <7cc4e81bdafd61649ac2b3f628083bd1@gerhard-bertelsmann.de>
 <20210330100411.x4syylvj4hjprhe4@pengutronix.de>
Message-ID: <daee4bc442600097fcd4b0f9974f79ef@gerhard-bertelsmann.de>
X-Sender: info@gerhard-bertelsmann.de
User-Agent: Roundcube Webmail/1.2.3
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

Am 2021-03-30 12:04, schrieb Marc Kleine-Budde:
> On 30.03.2021 09:10:10, Gerhard Bertelsmann wrote:
>> I'm trying to get a MCP2515 working with an OpenWRT router connected 
>> to the
>> second SPI channel (CS1). The first one is used by the flash. Here the 
>> error
>> message while loading the mcp251x module (Kernel 5.10.26):
> 
> Can you try the patch I just send to the mailing list?
> 
> https://lore.kernel.org/r/20210330100246.1074375-1-mkl@pengutronix.de

that looks much better now:
[  491.356961] mcp251x spi0.1 can0: MCP2515 successfully initialized.

I have to fix the GPIO irq before I can test the whole driver and giving
the Tested-by tag.

Thx for your fast help.

Regards

Gerd
