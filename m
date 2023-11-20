Return-Path: <linux-can+bounces-35-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C77F1855
	for <lists+linux-can@lfdr.de>; Mon, 20 Nov 2023 17:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7F61F251A8
	for <lists+linux-can@lfdr.de>; Mon, 20 Nov 2023 16:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503C1DFC7;
	Mon, 20 Nov 2023 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ka-long.de header.i=@ka-long.de header.b="YfSqmjkc"
X-Original-To: linux-can@vger.kernel.org
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 08:16:44 PST
Received: from dd15738.kasserver.com (dd15738.kasserver.com [85.13.151.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926DD51
	for <linux-can@vger.kernel.org>; Mon, 20 Nov 2023 08:16:44 -0800 (PST)
Received: from dd15738.kasserver.com (dd0805.kasserver.com [85.13.161.253])
	by dd15738.kasserver.com (Postfix) with ESMTPSA id AA49E5B00817;
	Mon, 20 Nov 2023 17:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ka-long.de;
	s=kas202309031034; t=1700496666;
	bh=UNTwFpRG+W048dcAxu8qpseZjf27XDi6hOJWwU9yoQw=;
	h=Subject:To:From:Date:From;
	b=YfSqmjkcFOYCq3kyt/LeYs18WM8lYVBKq27MuYZkGV3BryOacvbNQ8CcoDrf4Cggs
	 1sDNmi+skl2/8juP7XRF9yNiy/XYlSX4m3rVVFXO6IYK34OvS5NAoYAPriLEvhZW4Y
	 TFehVTN9DIkK/xIA5k3sopFL4rwGP/pyj9wguAXqesEbF8PJHZtSGRMK+hW/L5dbF/
	 ML39Vgnlhq4U7gIDjdfgMk4HvbHO2Szmhta6mnIZIA9yX6jX9NIR1g6qN5bUloI+Tf
	 YpgnQgUY9By+lwPk/FH33Y2QRPDb/MorxigoXnvBekuta9A5o3kGsRl1ob9GH5jjOl
	 dzW4z9yyQ9jKg==
Subject: mcp251xfd on NXP LX2160A
To: linux-can@vger.kernel.org, mkl@pengutronix.de
From: petter@ka-long.de
User-Agent: ALL-INKL Webmail 2.11
X-SenderIP: 147.161.255.85
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20231120161106.AA49E5B00817@dd15738.kasserver.com>
Date: Mon, 20 Nov 2023 17:11:06 +0100 (CET)
X-Spamd-Bar: /

Hi Folks,

Some time ago I have asked for help for mcp251xfd driver with an IMX7D, so I am somehow familar with the system.
The next iteration is with a NXP LX 2160A ... new hardware platform ... new kernel (6.1.1) ... new problems ;)

What is working : Driver is successfully initialised.
❯ sudo modprobe mcp251xfd
[ 4493.557075] mcp251xfd spi1.2 can2: MCP2518FD rev0.0 (-RX_INT -PLL -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD o:40.00MHz c:40.00MHz m:8.00MHz rs:8.00MHz es:0.00MHz rf:8.00MHz ef:0.00MHz) successfully initialized.

If I use a "wrong" interrupt for testing purposes (interrupt wont get it to the driver code), I am able to send one CAN Message from SPI CAN to LX2160A internal CAN (cangen/candump). Then the driver stuck.
This is more or less expected.

Enable the interrupt on the right pin (IRQ_LEVEL_LOW) does make some trouble. Driver is successfully initialised. If I bring up the interface (ip link set canx type can bitrate 500000 ; ip link set canx up)
I will get contineous errors:

.
.
. 
[  508.352616] mcp251xfd spi1.2 can2: CRC write error detected. CRC=0x6844.
[  508.362081] mcp251xfd spi1.2 can2: CRC write command format error.
[  508.368956] mcp251xfd spi1.2 can2: CRC write command format error.
[  508.375242] mcp251xfd spi1.2 can2: CRC write command format error.
[  508.381531] mcp251xfd spi1.2 can2: CRC write command format error.
[  508.387822] mcp251xfd spi1.2 can2: CRC write command format error.
[  508.394117] mcp251xfd spi1.2 can2: CRC write command format error.
[  508.400402] mcp251xfd spi1.2 can2: CRC write command format error.
[  508.406700] mcp251xfd spi1.2 can2: CRC write error detected. CRC=0x537f.
.
.
.

Since driver successfully initializes, no CRC read errors and sending a frame is working I assume SPI itself is okay.
/proc/interrupt shows only one additonal interrupt during a down / up cycle. This indicates that the interrupt is never cleared via SPI.
Since the error is a command error assuming the command is the one clearing the interrupt, that makes sense.
What can be the reason for the command format error ? Any ideas how to investigate further ?

BR
Niels



