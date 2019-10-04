Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCADCBCA8
	for <lists+linux-can@lfdr.de>; Fri,  4 Oct 2019 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfJDOIB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 4 Oct 2019 10:08:01 -0400
Received: from mail.bitwise.fi ([109.204.228.163]:42118 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388376AbfJDOIB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 4 Oct 2019 10:08:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 5C90760064;
        Fri,  4 Oct 2019 17:07:59 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.bitwise.fi
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mail.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ixu5CHAYv1T1; Fri,  4 Oct 2019 17:07:53 +0300 (EEST)
Received: from [192.168.5.238] (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id F207260027;
        Fri,  4 Oct 2019 17:07:52 +0300 (EEST)
Subject: Re: [PATCH] can: xilinx_can: avoid non-requested bus error frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-can@vger.kernel.org,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20191004090256.13931-1-anssi.hannula@bitwise.fi>
 <4dcb57b0-2fd1-573f-dfc6-0fef104249fe@pengutronix.de>
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
Message-ID: <b0b80891-54ca-c0dc-afb5-127d4bb05a8b@bitwise.fi>
Date:   Fri, 4 Oct 2019 17:07:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4dcb57b0-2fd1-573f-dfc6-0fef104249fe@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 4.10.2019 16.54, Marc Kleine-Budde wrote:
> On 10/4/19 11:02 AM, Anssi Hannula wrote:
>> Userspace can signal with CAN_CTRLMODE_BERR_REPORTING whether they need
>> reporting of bus errors (CAN_ERR_BUSERROR) or not.
>>
>> However, xilinx_can driver currently always sends CAN_ERR_BUSERROR
>> frames to userspace on bus errors.
>>
>> To improve performance on error conditions when bus error reporting is
>> not needed, avoid sending CAN_ERR_BUSERROR frames unless requested via
>> CAN_CTRLMODE_BERR_REPORTING.
>>
>> The error interrupt is still kept enabled as there is no dedicated state
>> transition interrupt, but just disabling error frame submission still
>> yields a significant performance improvement. In a simple test with
>> continuous bus errors and no userspace programs reading/writing CAN I
>> saw system CPU load reduced by 1/3.
>>
>> Tested on a ZynqMP board with CAN-FD v1.0.
>>
>> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
>> ---
>>  drivers/net/can/xilinx_can.c | 84 +++++++++++++++++++-----------------
>>  1 file changed, 45 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
>> index 911b34316c9d..9b9ec07f7e5b 100644
>> --- a/drivers/net/can/xilinx_can.c
>> +++ b/drivers/net/can/xilinx_can.c
>> @@ -471,6 +471,10 @@ static int xcan_chip_start(struct net_device *ndev)
>>  		return err;
>>  
>>  	/* Enable interrupts */
>> +	/* We enable the ERROR interrupt even with CAN_CTRLMODE_BERR_REPORTING
>> +	 * disabled as there is no dedicated interrupt for a state change to
>> +	 * ERROR_WARNING/ERROR_PASSIVE.
>> +	 */
>>  	ier = XCAN_IXR_TXOK_MASK | XCAN_IXR_BSOFF_MASK |
>>  		XCAN_IXR_WKUP_MASK | XCAN_IXR_SLP_MASK |
>>  		XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
>> @@ -981,11 +985,10 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
>>  {
>>  	struct xcan_priv *priv = netdev_priv(ndev);
>>  	struct net_device_stats *stats = &ndev->stats;
>> -	struct can_frame *cf;
>> -	struct sk_buff *skb;
>> +	struct can_frame cf;
>>  	u32 err_status;
>>  
>> -	skb = alloc_can_err_skb(ndev, &cf);
>> +	memset(&cf, 0, sizeof(cf));
> This change is unrelated to the one described. Please move these into a
> seperate patch.
>

It is related - the SKB allocation has to be delayed as we no longer
know at this point whether the SKB is needed or not.
So a temporary can_frame is used instead.

Or should I still move it to a separate patch along lines of "delay CAN
error frame SKB allocation to accommodate a following commit where we do
not want to always allocate it"?
I'd side on keeping it together, but your call :)

-- 
Anssi Hannula / Bitwise Oy
+358 503803997

