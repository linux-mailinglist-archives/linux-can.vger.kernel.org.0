Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C11A7415
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2019 21:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfICTzz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Sep 2019 15:55:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:26285 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfICTzz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Sep 2019 15:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567540551;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=DLVCyKVknR103pSkoxuWHv0uc4mPJU+2xNlxcQAZoAM=;
        b=FkED1eO+Js9ygV2xkRswedk41WKv3ZOR+e070qz93dTvyNLoQC/Oxd8uvlyegBIwfl
        +BDSuSRU0aVERTqvA/l63Qku2h8wAOX5ZYXWogjWtz3pTRb1wsAgOrBmvV8u2OjzW0So
        cIvGhUM991M8lyvxMWKCquQ/hYUj9yZ2zOiD4pFyUeNJ44iu9zr9fIOy8EJrvoEx4N0w
        USi9iAlzmusA0IrUuxhFK+pD4H0w4S8E2V8002xtOknBxkddDdaZxC4VeASfLWdGU3t0
        tNqNt6dda20f3TaHbvserLy66q8WAr2FVf5PRwfmENNVhmjuQG4u5IfpL5lTzdJz5WZh
        biQQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1r27UaEWJ+6BEwpjB"
X-RZG-CLASS-ID: mo00
Received: from [172.31.14.27]
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id j0667fv83JtnOe3
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 3 Sep 2019 21:55:49 +0200 (CEST)
Subject: Re: [PATCH 21/21] can: add support of SAE J1939 protocol
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        kbuild test robot <lkp@intel.com>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Robin van der Gracht <robin@protonic.nl>,
        Elenita Hinds <ecathinds@gmail.com>, kernel@pengutronix.de,
        Bastian Stender <bst@pengutronix.de>
References: <20190828065226.23604-1-mkl@pengutronix.de>
 <20190828065226.23604-22-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ae1439da-52c4-298b-e6da-11868b54283d@hartkopp.net>
Date:   Tue, 3 Sep 2019 21:55:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828065226.23604-22-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc, hi Oleksij,

compiled on top of latest net-next tree:

net/can/j1939/transport.c: In function ‘j1939_tp_recv’:
net/can/j1939/transport.c:1955:19: warning: this statement may fall 
through [-Wimplicit-fallthrough=]
    skcb->addr.type = J1939_ETP;
    ~~~~~~~~~~~~~~~~^~~~~~~~~~~
net/can/j1939/transport.c:1956:2: note: here
   case J1939_TP_PGN_DAT: /* falltrough */
   ^~~~
net/can/j1939/transport.c:1961:19: warning: this statement may fall 
through [-Wimplicit-fallthrough=]
    skcb->addr.type = J1939_ETP;
    ~~~~~~~~~~~~~~~~^~~~~~~~~~~
net/can/j1939/transport.c:1962:2: note: here
   case J1939_TP_PGN_CTL: /* falltrough */
   ^~~~
net/can/j1939/transport.c: In function ‘j1939_xtp_rx_dat_one’:
net/can/j1939/transport.c:1700:6: warning: this statement may fall 
through [-Wimplicit-fallthrough=]
    if (skcb->addr.type == J1939_ETP)
       ^
net/can/j1939/transport.c:1702:2: note: here
   case J1939_TP_CMD_BAM:
   ^~~~
net/can/j1939/transport.c:1704:6: warning: this statement may fall 
through [-Wimplicit-fallthrough=]
    if (skcb->addr.type != J1939_ETP)
       ^
net/can/j1939/transport.c:1706:2: note: here
   default:
   ^~~~~~~
net/can/j1939/transport.c: In function ‘j1939_tp_cmd_recv’:
net/can/j1939/transport.c:1873:8: warning: this statement may fall 
through [-Wimplicit-fallthrough=]
    extd = J1939_ETP;
    ~~~~~^~~~~~~~~~~
net/can/j1939/transport.c:1874:2: note: here
   case J1939_TP_CMD_BAM: /* falltrough */
   ^~~~
net/can/j1939/transport.c:1894:8: warning: this statement may fall 
through [-Wimplicit-fallthrough=]
    extd = J1939_ETP;
    ~~~~~^~~~~~~~~~~
net/can/j1939/transport.c:1895:2: note: here
   case J1939_TP_CMD_CTS: /* falltrough */
   ^~~~
net/can/j1939/transport.c:1920:8: warning: this statement may fall 
through [-Wimplicit-fallthrough=]
    extd = J1939_ETP;
    ~~~~~^~~~~~~~~~~
net/can/j1939/transport.c:1921:2: note: here
   case J1939_TP_CMD_EOMA: /* falltrough */
   ^~~~

This should be fixed before upstream.

Regards,
Oliver
