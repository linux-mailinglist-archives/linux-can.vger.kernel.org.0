Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F99CF493
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 10:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfJHIHU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 04:07:20 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:37244 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfJHIHU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 04:07:20 -0400
X-ASG-Debug-ID: 1570522036-0a7b8d13bfc9400001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b02.edpnet.be with ESMTP id WsZHhIB1moDkdact; Tue, 08 Oct 2019 10:07:16 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 5B1B1A471CA;
        Tue,  8 Oct 2019 10:07:16 +0200 (CEST)
Date:   Tue, 8 Oct 2019 10:07:11 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: Re: [PATCH v3 0/4] can: c_can/rx-offload
Message-ID: <20191008080711.GA20524@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH v3 0/4] can: c_can/rx-offload
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
References: <20191008075226.12544-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008075226.12544-1-mkl@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570522036
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1559
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5241 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77210
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 08 okt 2019 09:52:22 +0200, Marc Kleine-Budde wrote:
> Date: Tue,  8 Oct 2019 09:52:22 +0200
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> To: linux-can@vger.kernel.org
> Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Joe Burmeister
>  <joe.burmeister@devtank.co.uk>
> Subject: [PATCH v3 0/4] can: c_can/rx-offload
> X-Mailer: git-send-email 2.23.0
> 
> Hello,
> 
> taking up Kurt's work. I've cleaned up the rx-offload and c_can patches
> a bit. Untested as I don't have any hardware at hand.

I had created equivalent code (skb_queue in isr, skb_dequeue in napi
handler) running on a 4.9 kernel since some days now. I didn't observe
any problems yet.

> 
> I just looked at the c_can and d_can datasheets. Am I right, that both
> cores don't have a timestamp register to indicate when a CAN frame has
> been received?

I had the same impression.
The core clearly has not been built as a FIFO, but 'message objects'.
Hence the magic in the isr for trying to maintain proper sequence of
messages.

> 
> regards,
> Marc
> 
> Changes since v2:
> - added can_rx_offload_add_manual()
> - cleaned up c_can_isr()
>   - remove unneeded dev_id cast
>   - rename intreg -> reg_int to match the rest of the code
>   - use { } on both sides of if else
>   - fix return value
> - use can_rx_offload_add_manual() instead of can_rx_offload_add_fifo()
> - move can_rx_offload_add_manual()/can_rx_offload_del() to
>   register_c_can_dev()/unregister_c_can_dev()
> - move include rx-offload.h to c_can.h
> 
> 
> 
