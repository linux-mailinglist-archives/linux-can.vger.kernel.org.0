Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBE723FDC1
	for <lists+linux-can@lfdr.de>; Sun,  9 Aug 2020 13:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgHILBl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 9 Aug 2020 07:01:41 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35711 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHILBk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 9 Aug 2020 07:01:40 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BPbkp0wWRz1qrfh;
        Sun,  9 Aug 2020 13:01:38 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BPbkp0Vcqz1qy5j;
        Sun,  9 Aug 2020 13:01:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id f3QGWeCBgNht; Sun,  9 Aug 2020 13:01:36 +0200 (CEST)
X-Auth-Info: 8bBY817SxvuetW2hNo23hxU++0WgU8G4pJ/hmzNMQW0=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  9 Aug 2020 13:01:36 +0200 (CEST)
Subject: Re: [PATCH] can: m_can: Set pinmux into "default" state on start
To:     linux-can@vger.kernel.org
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>
References: <20200531181324.383930-1-marex@denx.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <419338dc-870d-51a4-87ac-ceddcba046dc@denx.de>
Date:   Sun, 9 Aug 2020 13:01:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200531181324.383930-1-marex@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 5/31/20 8:13 PM, Marek Vasut wrote:
> On systems like stm32mp1 where pins have both "default" and "sleep" pinmux
> states in DT, the pins are in "sleep" state by default. Switch the pins into
> the "default" state when bringing the interface up in m_can_start(), because
> otherwise no CAN communication is possible. This replicates the behavior of
> the resume path, which does the same.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> To: linux-can@vger.kernel.org
> ---
>  drivers/net/can/m_can/m_can.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 02c5795b7393..76fadf2b8ac2 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1247,6 +1247,8 @@ static void m_can_start(struct net_device *dev)
>  	/* basic m_can configuration */
>  	m_can_chip_config(dev);
>  
> +	pinctrl_pm_select_default_state(cdev->dev);
> +
>  	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
>  
>  	m_can_enable_all_interrupts(cdev);
> 

Any news on this ?
