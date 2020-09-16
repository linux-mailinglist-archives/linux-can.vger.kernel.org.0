Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7586B26C902
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 21:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgIPTBw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Sep 2020 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgIPRsw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Sep 2020 13:48:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC14C061222;
        Wed, 16 Sep 2020 04:04:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j11so9803624ejk.0;
        Wed, 16 Sep 2020 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8yyOs8M38oSzNrlEQXmu5SSo5wKakYP4BlxDSuTxupc=;
        b=ggjcPcajfgPW1CHntIHR3hz80OMBSbQU7Gwc9RoXmAnGM9T3eNT3gICD5QzpSFGWRl
         JlA3WUd8EvzBglannUWdaHxayk78gS8ezQxXkBo+9Yew9KOOZWVDe2bMNsr+EX7yY72l
         rAYAuo5SEljjGbL845wHOLWY/37a2YCtbHzyLmuqOid2Vwr3zlpsGOWHwbMGdOvrJ//I
         KL+3n7NCtchkaAOl8RVgllX7HXv0wLi1KI6yT2Yhwq+ScxV8dFeFf6lWFjJ4Qv9GQfTI
         ztuHvm+w2aNZTjBzpeffzd1TFYVOpstvWQTCtSLZ0vEjoKLtdDD3hoSYllsBjpPNnY5r
         59lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8yyOs8M38oSzNrlEQXmu5SSo5wKakYP4BlxDSuTxupc=;
        b=GhVVH3wRDY3VANoACWS0pDms4MfZY23vYDau5/8EGRVVHQsYCxL/uOe19o0jy+1inJ
         EkZCcJ8DBUyLq/g11x8p6d4172MFUAo05TYnmWbwycOPMj0hTsje5ppXTFJv1K5IPrkB
         QkbwzlCyo1h992kCqCcQDNgZLuNzr5Cpcf3ojrJtVH4VvdPEly49f/CjgBRpU8+wFilt
         cQsZ+FuyCHsEzQkZCrv6OeTuqumfMsun2JGEPEVcH0zabp69+WKItCjEEdyqvE9EtFqc
         mlwv4jRacTHqHzyI+eTyHmDuSLo1A20d6KDG743R6PvqCHFbqroeFTExrn7MeA4kAjXW
         LUyg==
X-Gm-Message-State: AOAM531ogubLMrHnUJS7xx84tinlsI3JrfEtZWCKf3jYvE4/yF8X3vce
        YtdX+L0M3vFpmIf3RA8lRps1ucp1B2U=
X-Google-Smtp-Source: ABdhPJz9CxWsjmf+K1u1jhtjPkh8nevL8QCMYOLC8Q8Nj6rdeZsSCgHqbOd7t84pBrr8/BKOhvnmig==
X-Received: by 2002:a17:906:88d:: with SMTP id n13mr25343926eje.75.1600254291481;
        Wed, 16 Sep 2020 04:04:51 -0700 (PDT)
Received: from skbuf ([188.25.217.212])
        by smtp.gmail.com with ESMTPSA id ch29sm13931115edb.74.2020.09.16.04.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 04:04:51 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:04:48 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     wg@grandegger.com, pankaj.bansal@nxp.com,
        pankaj.bansal@oss.nxp.com, mkl@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org,
        vladimir.oltean@nxp.com
Subject: Re: canfdtest on flexcan loopback
Message-ID: <20200916110448.dsla6vjzy4fvdr22@skbuf>
References: <VI1PR04MB4093944944C574B138371F51F12F0@VI1PR04MB4093.eurprd04.prod.outlook.com>
 <20200916110154.hp4up6yhyokduvf2@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916110154.hp4up6yhyokduvf2@skbuf>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

[ resending, forgot to copy Wolfgang ]

On Wed 9/2/2020 10:09 AM, Wolfgang Grandegger wrote:
> canfdtest normally runs on the DUT *and* a the host. The DUT receives
> the messages from the host, increments the frame data bytes and then
> sends them back to the host. With "loopback" mode, the data bytes are
> not incremented and that's what you see above.
>
> Wolfgang

Wolfgang is of course right, but we're nonetheless investigating what
seems to be a real problem, and what Pankaj had seen was a red herring.

So currently what I suspect is going on, when I am running canfdtest
between 2 LS1028A-RDB boards, is that the DUT is reordering frames on
TX.

See, for example, the screenshot below:
https://drive.google.com/file/d/1rOeW3aXh3kPh1CJ39lCccRfjFz5JN5I6/view?usp=sharing

I have added trace points to the end of the flexcan_start_xmit function,
which print the entire skb, and the frames appear to be written to the
TX message buffer in the correct order. They are seen, however, in the
incorrect order on the wire.

Thanks,
-Vladimir
