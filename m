Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB13CDF36
	for <lists+linux-can@lfdr.de>; Mon,  7 Oct 2019 12:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfJGKYx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Oct 2019 06:24:53 -0400
Received: from mail.bitwise.fi ([109.204.228.163]:37612 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGKYx (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 7 Oct 2019 06:24:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 74A9E60045;
        Mon,  7 Oct 2019 13:24:51 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.bitwise.fi
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mail.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oLtXDYRFVOhG; Mon,  7 Oct 2019 13:24:49 +0300 (EEST)
Received: from [192.168.5.238] (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id 0C14C60047;
        Mon,  7 Oct 2019 13:24:49 +0300 (EEST)
Subject: Re: [PATCH v2] can: xilinx_can: avoid non-requested bus error frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     michal.simek@xilinx.com, appana.durga.rao@xilinx.com
References: <20191004203033.4582-1-mkl@pengutronix.de>
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
Message-ID: <29b77145-4fe1-c39b-3dae-286582f28962@bitwise.fi>
Date:   Mon, 7 Oct 2019 13:24:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191004203033.4582-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 4.10.2019 23.30, Marc Kleine-Budde wrote:
> From: Anssi Hannula <anssi.hannula@bitwise.fi>
>
> Userspace can signal with CAN_CTRLMODE_BERR_REPORTING whether they need
> reporting of bus errors (CAN_ERR_BUSERROR) or not.
>
> However, xilinx_can driver currently always sends CAN_ERR_BUSERROR
> frames to userspace on bus errors.
>
> To improve performance on error conditions when bus error reporting is
> not needed, avoid sending CAN_ERR_BUSERROR frames unless requested via
> CAN_CTRLMODE_BERR_REPORTING.
>
> The error interrupt is still kept enabled as there is no dedicated state
> transition interrupt, but just disabling error frame submission still
> yields a significant performance improvement. In a simple test with
> continuous bus errors and no userspace programs reading/writing CAN I
> saw system CPU load reduced by 1/3.
>
> Tested on a ZynqMP board with CAN-FD v1.0.
>
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
>
> taking up Anssi Hannula's work.
>
> changes since v1:
> - xcan_err_interrupt(): use C99 initializers instead of memset() to
>   initialize struct can_frame cf.
> - xcan_err_interrupt(): convert initialization of berr_reporting to use
>   "if".
>
> Please test.

Thanks, I tried it on my HW and it seems to work like v1.


> regards,
> Marc
>
>  drivers/net/can/xilinx_can.c | 89 +++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 41 deletions(-)
[...]

-- 
Anssi Hannula / Bitwise Oy
+358 503803997

