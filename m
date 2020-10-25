Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB38D298164
	for <lists+linux-can@lfdr.de>; Sun, 25 Oct 2020 11:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415252AbgJYK6m (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 25 Oct 2020 06:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415239AbgJYK6l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 25 Oct 2020 06:58:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C0BC0613CE
        for <linux-can@vger.kernel.org>; Sun, 25 Oct 2020 03:58:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kWdjN-0000sz-NI; Sun, 25 Oct 2020 11:58:33 +0100
Received: from hardanger.blackshift.org (2a03-f580-87bc-d400-c273-c166-ced0-255f.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:c273:c166:ced0:255f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4D08E581192;
        Sun, 25 Oct 2020 10:58:32 +0000 (UTC)
Date:   Sun, 25 Oct 2020 11:58:08 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Drew Fustini <drew@beagleboard.org>, linux-can@vger.kernel.org,
        Josh S <josh@macchina.cc>
Subject: Re: mcp251xfd on RPi 5.4 downstream
Message-ID: <20201025105808.2pltif74at3xwtjd@hardanger.blackshift.org>
References: <CAPgEAj5eeN7Q9Hs7ZcrvaNCQJ7uW8kyNs3CPiVfQ=AEX9WeYoQ@mail.gmail.com>
 <CAPgEAj5HwFUTqhbgZ2Y5Db-_PPHNN7Rc8dnp1s+TBBALf5EwSw@mail.gmail.com>
 <3ede1c31-9436-a8ec-b7cd-65cee5fa23fc@pengutronix.de>
 <CAPgEAj7JLUjWiN8LdGV9OfQScsUkPVcs9bSE+w_9G0c9BNd-sg@mail.gmail.com>
 <CAPgEAj6nQOAQ9NNB2QBbARuqWm5K62QW+NsqPROzcQOZqe-F+g@mail.gmail.com>
 <975a3598-c229-0b9a-df95-c9647f138a3a@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975a3598-c229-0b9a-df95-c9647f138a3a@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun, Oct 25, 2020 at 09:49:43AM +0100, Oliver Hartkopp wrote:
> > > Thanks, will do.   I am currently trying to finish up my ELC-E talk
> > > prep :) but will get back to you with the results of testing later.
> > 
> > I noticed up doing a modprobe that there are several Unknown symbol errors.
> > 
> > Any ideas?
> > 
> > [  358.686691] mcp251xfd: Unknown symbol can_rx_offload_del (err -2)
> > [  358.686744] mcp251xfd: Unknown symbol can_put_echo_skb (err -2)
> > [  358.686796] mcp251xfd: Unknown symbol can_len2dlc (err -2)
> > [  358.686844] mcp251xfd: Unknown symbol alloc_canfd_skb (err -2)
> > [  358.686942] mcp251xfd: Unknown symbol open_candev (err -2)
> > [  358.687042] mcp251xfd: Unknown symbol alloc_can_skb (err -2)
> > [  358.687093] mcp251xfd: Unknown symbol unregister_candev (err -2)
> > [  358.687139] mcp251xfd: Unknown symbol can_change_state (err -2)
> > [  358.687183] mcp251xfd: Unknown symbol can_change_mtu (err -2)
> > [  358.687227] mcp251xfd: Unknown symbol can_rx_offload_add_manual (err -2)
> > [  358.687294] mcp251xfd: Unknown symbol free_candev (err -2)
> > [  358.687345] mcp251xfd: Unknown symbol alloc_candev_mqs (err -2)
> > [  358.687416] mcp251xfd: Unknown symbol close_candev (err -2)
> > [  358.687475] mcp251xfd: Unknown symbol can_bus_off (err -2)
> > [  358.687519] mcp251xfd: Unknown symbol can_rx_offload_enable (err -2)
> > [  358.687569] mcp251xfd: Unknown symbol can_rx_offload_get_echo_skb (err -2)
> > [  358.687656] mcp251xfd: Unknown symbol can_dlc2len (err -2)
> > [  358.687710] mcp251xfd: Unknown symbol alloc_can_err_skb (err -2)
> > [  358.687773] mcp251xfd: Unknown symbol can_rx_offload_queue_sorted (err -2)
> > [  358.687819] mcp251xfd: Unknown symbol register_candev (err -2)
> > [  369.092608] CAN device driver interface
> 
> The can-dev module has been loaded *after* mcp251xfd.
> 
> Don't know why autoloading did not work on your machine but doing a
> 'modprobe can-dev' before loading the MCP driver should do it for a test.
> 
> > root@raspberrypi:~# modinfo mcp251xfd
> > filename:
> > /lib/modules/5.4.72-v7l+/kernel/drivers/net/can/spi/mcp251xfd/mcp251xfd.ko
> > license:        GPL v2
> > description:    Microchip MCP251xFD Family CAN controller driver
> > author:         Marc Kleine-Budde <mkl@pengutronix.de>
> > srcversion:     1E05EEB5939E9AB22BA2E1B
> > alias:          spi:mcp251xfd
> > alias:          spi:mcp2518fd
> > alias:          spi:mcp2517fd
> > alias:          of:N*T*Cmicrochip,mcp251xfdC*
> > alias:          of:N*T*Cmicrochip,mcp251xfd
> > alias:          of:N*T*Cmicrochip,mcp2518fdC*
> > alias:          of:N*T*Cmicrochip,mcp2518fd
> > alias:          of:N*T*Cmicrochip,mcp2517fdC*
> > alias:          of:N*T*Cmicrochip,mcp2517fd
> > depends:        can-dev
                    ^^^^^^^
> > intree:         Y
> > name:           mcp251xfd
> > vermagic:       5.4.72-v7l+ SMP mod_unload modversions ARMv7 p2v8

The dependencies are correct. Try running a "depmod -a". If you are on a distro
with udev, manual modprobe should not be needed, as udev should load all needed
modules automatically during boot.

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
