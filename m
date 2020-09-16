Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8DE26C972
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 21:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgIPTJ3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Sep 2020 15:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgIPRnt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Sep 2020 13:43:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C318FC061220;
        Wed, 16 Sep 2020 04:01:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l17so5798154edq.12;
        Wed, 16 Sep 2020 04:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=f6gBl1x/o83U9v6TkMazyXIZKggUPpY2KATUn29zmFU=;
        b=ILW3UNWsoHPKtyHaJaBvEo2QrCUU6rZjdhhFeFCwUwyO5uXIYZRjBXmSuUKCRj1oCG
         VOC9Qh79qB0qj9plRJEnfFSzb8dRAtd35wiijjE8LsrdyJqtlrDd5EZdvrR1zgECJG+y
         04lY366RXF7AD59y8E+1gNQDw7ahUxvibSSrt66ZCW6TJo6SaVZ84hjRe+paVwYwPph8
         gNpk2uX1WZhaqOpdKlG2zKCp/H6LUg/PApK6lkIbG0msw4r8xHNeRiRPo5qEl71d6k/7
         kIGZOl5ZsxC2Bl077OiJW7GEpKmvPYg4lEGFodCbXqm0jPXtETsvTM2hwx4esYCrZPw4
         WLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=f6gBl1x/o83U9v6TkMazyXIZKggUPpY2KATUn29zmFU=;
        b=jOKPsAsDEys/ffPcwnl2ioTAo9NUTWg2lt0Maw3uoyGUUKDh/H9dFVk6r/S9v15jJo
         yZsZKH6qTzR3Kkf7K+v1/v9ghFZOjEan4KUEqpZ1UxOT0YBy8rNT6UmDxUA/R3AOTNyO
         7M+EoOSjPqnoouu+ITA2U2fjXYJDBCaeWllSCl4kaU5LyEyQ2R9J9EPnYHpvB/y/zdnv
         kWl2EULt4Rcf3FTRctWlzQlQhEpyT1gdZLr2aEtudeOEnGtH5V+FQ8T4KR6n/3kyAxX5
         s36/vW3HM/yCYswTAVRLDzxDirrmSRrYxl2sqcvfZ2h+lU2V3/2qTyS7jjz9Ki2n/GW+
         qR7g==
X-Gm-Message-State: AOAM531Y2TeSJupI/PkG1H/pnHHIfhzIzHTqYRRrevApch8bbT7Ye/Bd
        ONsomgxtt7XmTychXU3mKK4=
X-Google-Smtp-Source: ABdhPJxruDKya2RnudTwDrLGxUPfcPxghoMLkVz/CqLyEy7TthpXI90k7jitfGr8NFLWcyzTmMWllA==
X-Received: by 2002:a50:baed:: with SMTP id x100mr11659390ede.384.1600254117074;
        Wed, 16 Sep 2020 04:01:57 -0700 (PDT)
Received: from skbuf ([188.25.217.212])
        by smtp.gmail.com with ESMTPSA id l15sm12218265ejk.50.2020.09.16.04.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 04:01:56 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:01:54 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     pankaj.bansal@nxp.com, pankaj.bansal@oss.nxp.com,
        mkl@pengutronix.de, linux-can@vger.kernel.org
Cc:     qiangqing.zhang@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: canfdtest on flexcan loopback
Message-ID: <20200916110154.hp4up6yhyokduvf2@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4093944944C574B138371F51F12F0@VI1PR04MB4093.eurprd04.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

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
