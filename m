Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1A3501A5
	for <lists+linux-can@lfdr.de>; Wed, 31 Mar 2021 15:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhCaNpu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 31 Mar 2021 09:45:50 -0400
Received: from mail.rdts.de ([195.243.153.28]:58884 "EHLO mail.rdts.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235755AbhCaNpT (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 31 Mar 2021 09:45:19 -0400
Received: from webmail.rdts.de (php1.rdts.de [82.223.13.20])
        by mail.rdts.de (Postfix) with ESMTPSA id 3BDAAA8631;
        Wed, 31 Mar 2021 15:45:18 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 Mar 2021 15:45:17 +0200
From:   Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Tim Harvey <tharvey@gateworks.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251x: fix support for half duplex SPI host
 controllers
In-Reply-To: <20210331071427.w4bplxt2hoiduho2@pengutronix.de>
References: <20210330100246.1074375-1-mkl@pengutronix.de>
 <CAJ+vNU0w2faqmW0MOA9FQD8=vxpJH1Lc8c0BMcAVKGNq1vNjjg@mail.gmail.com>
 <20210331071427.w4bplxt2hoiduho2@pengutronix.de>
Message-ID: <4366ddabaf5e0696f537ad3bcd8fa854@gerhard-bertelsmann.de>
X-Sender: info@gerhard-bertelsmann.de
User-Agent: Roundcube Webmail/1.2.3
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 2021-03-31 09:14, schrieb Marc Kleine-Budde:
> On 30.03.2021 14:06:03, Tim Harvey wrote:
>> On Tue, Mar 30, 2021 at 3:02 AM Marc Kleine-Budde <mkl@pengutronix.de> 
>> wrote:
>> >
>> > Some SPI host controllers do not support full-duplex SPI transfers.
>> >
>> > The function mcp251x_spi_trans() does a full duplex transfer. It is
>> > used in several places in the driver, where a TX half duplex transfer
>> > is sufficient.
>> >
>> > To fix support for half duplex SPI host controllers, this patch
>> > introduces a new function mcp251x_spi_write() and changes all callers
>> > that do a TX half duplex transfer to use mcp251x_spi_write().
> 
>> So was the issue being resolved here that there was another SPI host
>> controller that wasn't advertising that it was half duplex only
> 
> I don't know which SPI host controller Gerhard uses, but I assume it 
> has
> half duplex set, as the driver probe fails with:
> 
> | [  112.226164] mcp251x spi0.1: spi transfer failed: ret = -22
> 
> The -22 is returned by the SPI framework if you have a half duplex
> controller and a transfer with both TX and RX buffer set. This is the
> case in the mcp251x_spi_trans() function.

I'm using an Onion Omega2 board with MT7688 CPU. It uses MediaTek MT7621
SPI controller driver - spi-mt7621.c (5.10.26) with sets the flag to:

         master->flags = SPI_CONTROLLER_HALF_DUPLEX;

All Mediatek/Ralink SPI controller are only half duplex AFAIK.

> 
>> or was something else wrong with e0e25001d088 ("can: mcp251x: add
>> support for half duplex controllers")?
> 
> Your patch only converted the SPI read path to use half duplex
> transfers. My patch also converts the SPI write path.

Without Marcs latest patch the MCP2515 didn't initialized correctly and
showed the error mentioned above (spi transfer failed).

Regards

Gerd
