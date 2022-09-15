Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C8C5B9AB6
	for <lists+linux-can@lfdr.de>; Thu, 15 Sep 2022 14:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiIOM0m (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Sep 2022 08:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIOM0i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Sep 2022 08:26:38 -0400
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Sep 2022 05:26:36 PDT
Received: from sypressi2.dnainternet.net (sypressi2.dnainternet.net [83.102.40.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F279624
        for <linux-can@vger.kernel.org>; Thu, 15 Sep 2022 05:26:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sypressi2.dnainternet.net (Postfix) with ESMTP id CDC6215635;
        Thu, 15 Sep 2022 15:18:09 +0300 (EEST)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Score: 2.975
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
Received: from sypressi2.dnainternet.net ([83.102.40.154])
        by localhost (sypressi2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id 0Fqk9xF3XJgj; Thu, 15 Sep 2022 15:18:09 +0300 (EEST)
Received: from kirsikkapuu2.dnainternet.net (kirsikkapuu2.dnainternet.net [83.102.40.52])
        by sypressi2.dnainternet.net (Postfix) with ESMTP id A5D25155A3;
        Thu, 15 Sep 2022 15:18:09 +0300 (EEST)
Received: from localhost (87-95-101-152.bb.dnainternet.fi [87.95.101.152])
        by kirsikkapuu2.dnainternet.net (Postfix) with ESMTP id 1F3427E;
        Thu, 15 Sep 2022 15:18:04 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 15 Sep 2022 15:18:02 +0300
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH v2 00/10] can: remove litteral strings used for driver
 names and remove DRV_VERSION
Message-ID: <YyLkrj5v2EiBIXk+@surfacebook>
References: <20220725153124.467061-1-mailhol.vincent@wanadoo.fr>
 <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726082707.58758-1-mailhol.vincent@wanadoo.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Tue, Jul 26, 2022 at 05:26:57PM +0900, Vincent Mailhol kirjoitti:
> This is a cleanup series.
> 
> The patches 1 to 8 get rid of any hardcoded strings and instead relies
> on the KBUILD_MODNAME macros to get the device name. Patch 9 replaces
> the ES58X_MODULE_NAME macro with KBUILD_MODNAME in
> etas_es58x. Finally, also in etas_es58x, patch 10 removes the
> DRV_VERSION so that the module uses the default behavior and advertise
> the kernel version instead of a custom version.

I guess you all understand that this is potential ABI breakage.
The driver can be instantiated by its name (for matching purposes) from board
files or MFD cell. If you change the name of the file, the module will be
changed and hence the breakage.

That said, NAK from me (as I do usually the opposite change).

-- 
With Best Regards,
Andy Shevchenko


