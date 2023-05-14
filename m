Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460DE701D90
	for <lists+linux-can@lfdr.de>; Sun, 14 May 2023 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjENNMb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 14 May 2023 09:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjENNMa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 14 May 2023 09:12:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F4E26B9
        for <linux-can@vger.kernel.org>; Sun, 14 May 2023 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1684069942; i=ps.report@gmx.net;
        bh=ifa9xOhUcdYKn/aQO+Z5jGRyVJXboOtCxLJ/ZIFgngU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=X5H7j35Ib/LAeDmxulY7C3yDFROSo80x/GZzKOC+QsHiZ1gH1/m+EVtkh8IARcwPa
         WN7aTpiQ/tyavaHbBQYyo8nZ4uAPbytBA1OxixqpTuGmm4BtPe+AmOLl3s2n65ZafN
         0pdDC4poXWbBmZj2DjlgZ/3Vc77+Havt3wlluDGw2YAMVJzG5mHqeSJHqJpq4uH4kI
         xmzolrb5zZ45BXcnqqscwszKxsRS0qjS86hDh8aV5hIafsTDwPhvPos9qrltl7ppVV
         1Z1FnDBFUjkUFdoCWZnYlbmsQGUFLt/ZQwLPaaMsBCXqFzq5N2NaSS1fBGlG86LBN2
         kcH90KbeMh9uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([62.216.209.255]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXUD-1piR9d2wh5-00JWWX; Sun, 14
 May 2023 15:12:22 +0200
Date:   Sun, 14 May 2023 15:12:21 +0200
From:   Peter Seiderer <ps.report@gmx.net>
To:     linux-can@vger.kernel.org
Cc:     Florian Ferg <flfe@hms-networks.de>
Subject: Any update for the IXXAT USB-to-CAN adapters drivers?
Message-ID: <20230514151221.049873cb@gmx.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4gXjoC+lGiUNUzXyYxs7P/ZHiP1VCaP9q5S0EOl7P9hhGfkERDI
 MZQS8FGcRLAqJ313AbgspFmFvyKJ9W3/FJ9vx8veK9mpcFie8AMNTKDDc+zRVlC6Msog12F
 /fXkJL2Rjv1VYhRv+0UOVS2k9enwAloewtnOR4kvpZjxGDvxep0MHO1Oq7One68a+ixFcr4
 LJkDKezlC0N2vi9TzZTbA==
UI-OutboundReport: notjunk:1;M01:P0:cwMKPHooIHc=;rK7C223dZ0In+A9iG6cy4mWac9v
 3wpmD13vLUX+srXwiUAS9nn0En3LuZ8NxYG+/NPq4TWzaFry6OBufjAf5k9vx/PbLOJP4VfWN
 kUI0xlIEr1Y779oa8Dko0IYZsiPWC2qfSDWxlOh0OGMLrY35ty016gEnfTvhB8GUG2fZDSqrQ
 UEQJVbrUPPoIlzn4BwgcOd8pfuq92lUF69SgkRfZ3Z5KQLs+oemj64QZXyzu44LnmxovaHYgw
 Y7Sxo0MvCKZQ3n9tYu7pfE1ppU3xBTsZcuGnrJZ1o98ZI24ZRx4TX6qwRIXMbcFudo4n4te1u
 ykMjSvZaU7TTaOoHg3mWmv2BQG/0sSqJm1uFd77ppjPiyXt8dIAVojK5CNzbzQOd+SlgdC6S9
 ozkiy1XEG4YnUSNX5NeOfjCJ6RWmyqgCLVhZbQ1fpaDAzXWTJULjcQy6o2WSDafDdfkdwlEJa
 x+BjhP9fv5iW0y7pQ4hefLTR0hJ90EAeNf0vCtBZTvJivlmdfQnFz+tmTF0pX9ItgwgAOdmSk
 qDeq7jRJD/JF9vVwLKtkwGmEUfM1w2Di2KZajNnu+FhtpdvDJCy+zG/B125Tk8fSJay0iLTJI
 g8pq9mfcAc/bpYF1Hk6n5RZX7dUPGCju/HJ2Xjs/ZMJg8bgBf8eNqn1mTQ/vMFIKfttsY2IYN
 IsdzGHPrDsjdbPNiFowz/oiw2z08C5MuaSHoHlPJZQPLmOFXkdHneTJGRK2NViKbJFFT3CuQ2
 nk9zX94LkOHymjD2FqBMR6G54hE2j6p82li8r1DKEkl0ad21AMtTMMGwTTgiXkHHTtXVME64z
 Ul1fEhfocjcKBZEts39/ZHX7I0Zmz3+dQesqlZyI64Bea4jk1LX/b+9x+BkTbNKf3LzNoFx4S
 CZU8IS7fHjKxJDkmSYUpyDu2EU/h3OfbXNuCbmZNPJhnG02NZf9SlW0sZ8eMKsWOPgy6EbtBf
 AFd9ToSauQON8RYmhrbVblHAbQk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

does anybody know what happened with the IXXAT USB-to-CAN adapters drivers
attempts to bring the patches upstream?

I found the following attempts

- 'Re: [PATCH] can: usb: IXXAT USB-to-CAN adapters drivers' ([1] from June 2018)
- '[PATCH v6] can: usb: IXXAT USB-to-CAN adapters drivers' ([2] from Sep 2018)

but now follow ups and/or references in the actual linux source tree...

Regards,
Peter


[1] https://marc.info/?l=linux-can&m=152857696410581
[2] https://www.spinics.net/lists/linux-can/msg00378.html
