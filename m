Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7EC2BA68B
	for <lists+linux-can@lfdr.de>; Fri, 20 Nov 2020 10:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKTJtW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Nov 2020 04:49:22 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:30822 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKTJtW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Nov 2020 04:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1605865757;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=buZxh9efwWpMUysXXlPGj7V3yQyvWgoZ5am0ea0FT9E=;
        b=NYkxdnjKsmUaIJwVnOvjyZ5+rPCgkVtMfw5ImcD6OfDdd5zom0ej1F8FgUItZdRHnX
        JBcFmjd/kIWuxCrDcGGjgbLLEHCnS74I/tk0BkVQM9TWUQ3YnVPuuHcMDVrqMNjxGme6
        Y90UPbOzHuUBRt4V0Ia5YFNp3wVFQgJk4bKMfdIK6ZF15IGHNai4+F7bQpmY4PBMpG12
        z3rbj/hTqEFq92otShKM4+ZehL05/aZ/tVp+hI1xAjA8lCHULc9TJM/0Wrx+bj6otLFN
        t/tPbIBEvw8Z2T/wcllKEUun/H8Uf5oHXr5s8PrvkEhplsHOkOZKML7TVPqcX2lx2oNw
        qbHQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iOMlqpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwAK9nFWZa
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 20 Nov 2020 10:49:15 +0100 (CET)
Subject: broken on next-next - [PATCH v6 4/8] can: replace can_dlc as
 variable/element for payload length
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org
References: <20201110101852.1973-1-socketcan@hartkopp.net>
 <20201110101852.1973-5-socketcan@hartkopp.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ed313f33-7a01-261f-5dc6-ecbd6037a3c7@hartkopp.net>
Date:   Fri, 20 Nov 2020 10:49:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201110101852.1973-5-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

I just rebased the len8_dlc patches on the latest net-next for testing.

And the patch a1e654070a60d5d4f ("can: dev: can_restart(): post buffer 
from the right context") renames netif_rx() to netif_rx_ni() which 
hinders this [PATCH v6 4/8] to apply properly.

Just FYI before you create a pull request for net-next ;-)

> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 6dee4f8f2024..566501a02b91 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c

(..)

> @@ -593,11 +593,11 @@ static void can_restart(struct net_device *dev)
>   	cf->can_id |= CAN_ERR_RESTARTED;
>   
>   	netif_rx(skb);
>   
>   	stats->rx_packets++;
> -	stats->rx_bytes += cf->can_dlc;
> +	stats->rx_bytes += cf->len;
>   

Best,
Oliver
