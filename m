Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06283193FEE
	for <lists+linux-can@lfdr.de>; Thu, 26 Mar 2020 14:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZNlE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 26 Mar 2020 09:41:04 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:33072 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZNlE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 26 Mar 2020 09:41:04 -0400
X-ASG-Debug-ID: 1585230022-0a7ff519ee8d5d20001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be ([77.109.89.38]) by relay-b01.edpnet.be with ESMTP id wchjMQSFC8b3nEsE; Thu, 26 Mar 2020 14:40:22 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[77.109.89.38]
X-Barracuda-Apparent-Source-IP: 77.109.89.38
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 16F4ADB7B96;
        Thu, 26 Mar 2020 14:40:22 +0100 (CET)
Date:   Thu, 26 Mar 2020 14:40:16 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Felix Riemann <felix.riemann@sma.de>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <andre.kalb@sma.de>
Subject: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Message-ID: <20200326134015.GC27785@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Mail-Followup-To: Felix Riemann <felix.riemann@sma.de>,
        linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Andre Kalb <andre.kalb@sma.de>
References: <20200326104318.15086-1-felix.riemann@sma.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326104318.15086-1-felix.riemann@sma.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: UNKNOWN[77.109.89.38]
X-Barracuda-Start-Time: 1585230022
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2498
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6536 1.0000 1.0441
X-Barracuda-Spam-Score: 1.54
X-Barracuda-Spam-Status: No, SCORE=1.54 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.80810
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch looks very familiar.
I tried this 6 months ago, when I got a setup where I could reproduce
this within minutes.

This patch didn't solve my problem, and I fixed my problem with reading the
ISR register only once in the IRQ, and _not_ 2nd time in napi handler.
Reading the ISR in C_CAN is consuming the info, so unless the there is
more state to clear (such as received message buffers), the interrupt
cause is assumed to be known, and the C_CAN proceeds to the next
interrupt cause.
I've not experienced a single problem since, where before the fix, I'd
experience a few occurances every month.
We have an am3358 (beaglebone-like hardware).

I believe I submitted a patch for that.

Re-scheduling the napi is a workaround, IMHO.

Kurt

On do, 26 mrt 2020 11:43:18 +0100, Felix Riemann wrote:
> There are appears to be a race condition where interrupts caused
> by bus offs get lost if it occurs while interrupts are disabled
> or being re-enabled.
> 
> This tries to avoid the deadlock by rescheduling the NAPI worker
> to handle the bus-off condition.
> 
> Signed-off-by: Felix Riemann <felix.riemann@sma.de>
> Reviewed-by: Andre Kalb <andre.kalb@sma.de>
> ---
>  drivers/net/can/c_can/c_can.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index 8e9f5620c9a2..0952ac0b9123 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -1123,8 +1123,25 @@ static int c_can_poll(struct napi_struct *napi, int quota)
>  	if (work_done < quota) {
>  		napi_complete_done(napi, work_done);
>  		/* enable all IRQs if we are not in bus off state */
> -		if (priv->can.state != CAN_STATE_BUS_OFF)
> +		if (priv->can.state != CAN_STATE_BUS_OFF) {
> +			u32 ctrl;
>  			c_can_irq_control(priv, true);
> +
> +			/* There appears to be a race condition when the device
> +			 * enters bus off while interrupts are off or being
> +			 * re-enabled causing the bus off to get lost.
> +			 * This tries to avoid this condition.
> +			 */
> +			ctrl = priv->read_reg(priv, C_CAN_CTRL_REG);
> +
> +			if (ctrl & CONTROL_INIT) {
> +				netdev_warn(dev, "lost bus off\n");
> +				c_can_irq_control(priv, false);
> +				/* Reschedule worker to handle bus off */
> +				atomic_set(&priv->sie_pending, 1);
> +				napi_reschedule(napi);
> +			}
> +		}
>  	}
>  
>  	return work_done;
> -- 
> 2.26.0
> 
