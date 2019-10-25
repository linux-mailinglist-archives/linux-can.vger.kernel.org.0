Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840A3E49A9
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2019 13:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfJYLQc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Oct 2019 07:16:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43363 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfJYLQc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Oct 2019 07:16:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so1861160wrr.10
        for <linux-can@vger.kernel.org>; Fri, 25 Oct 2019 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aggsABIYRRLswIwxQlk1bc5yL6gnA80dLaHTc+5bzIY=;
        b=ZfEnKerJnYGRWOAiA9ZGyMPPaOei4svG9M9ngzt/VRWxfhX1aGYgh7sICeNUFn1fR7
         t7icu56KqU/9tCId7Kbi7XkVfxv6YB4BLQPMyse3pLgbKdOBq2RnyADMVQmd7OK9ZdfE
         snsj1mRqO6GJrZCrrYszrJDK3DbAA75l/ppva5wwEcTvIw7vEnNc/cev+coPLU2L0ekv
         3wsk9Ftia043GAUvXZsDZix9D2JBQbktFGsKUG9Q4cii8tapwG9WaH+FCQQldf7eurht
         ucacZH6tfAmoBM06Wt/OCCtxtKp6bw0SPtuv54rM6jCPZXz5rxqyFhaMA2mYwITH16OH
         8b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aggsABIYRRLswIwxQlk1bc5yL6gnA80dLaHTc+5bzIY=;
        b=fpVOi4NfT0UHToOfpFvnnJ7GIGB1/Wyz0btZcabx7dcVw3X2R+kq3cbu3XQ0Ptef53
         sptwi7yHt9fJEdAk19rCEsOizo/UC3YRX6l/GbT6Z/VIQGAryk6/hrpp78CH1Y5Mf/Mv
         ShwxOwWVzJPgUiavu3KK5MkRhFK8Ktvd0cEX5gHgI2RXyOoM92uEcK4GCOUI6U9uf5Ze
         Iu3WIUuTipeqg2DqQ1TqNyROsc2tTGTi0IRtUeDh/ZNiKFTLxESdou6GduSvCkWst2mi
         OLyU1Un3D2/ACfIHPHbQAxcQtbQX/WeK9NdUGqt1FtnRR0bh32jt/qpw7TYOs2t7Z9Le
         iG+Q==
X-Gm-Message-State: APjAAAXtNEkIAeusesMyKffYa5LKl0UvckbfjAwvfdQ+hB2rAR40V1Xd
        fOcDVqWLCEbFnxTOQ0pmX7YV9Q==
X-Google-Smtp-Source: APXvYqye0bMzabbhMdyIpkhP6DJpiYxdibp9PiqfCR0Gpk686vQs9d9QZOMBWqPETxqNqJFJXkTTxw==
X-Received: by 2002:a5d:544d:: with SMTP id w13mr2562396wrv.19.1572002189723;
        Fri, 25 Oct 2019 04:16:29 -0700 (PDT)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id v20sm1571589wml.26.2019.10.25.04.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:16:29 -0700 (PDT)
Date:   Fri, 25 Oct 2019 13:16:27 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Pankaj Sharma <pankj.sharma@samsung.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net,
        eugen.hristev@microchip.com, ludovic.desroches@microchip.com,
        pankaj.dubey@samsung.com, rcsekar@samsung.com,
        jhofstee@victronenergy.com, Sriram Dash <sriram.dash@samsung.com>
Subject: Re: [PATCH v2] can: m_can: add support for handling arbitration error
Message-ID: <20191025111626.GA31153@netronome.com>
References: <CGME20191021121350epcas5p3313e54a3bc5c8600c52a6db299893f78@epcas5p3.samsung.com>
 <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571660016-29726-1-git-send-email-pankj.sharma@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Oct 21, 2019 at 05:43:36PM +0530, Pankaj Sharma wrote:
> The Bosch MCAN hardware (3.1.0 and above) supports interrupt flag to
> detect Protocol error in arbitration phase.
> 
> Transmit error statistics is currently not updated from the MCAN driver.
> Protocol error in arbitration phase is a TX error and the network
> statistics should be updated accordingly.
> 
> The member "tx_error" of "struct net_device_stats" should be incremented
> as arbitration is a transmit protocol error. Also "arbitration_lost" of
> "struct can_device_stats" should be incremented to report arbitration
> lost.
> 
> Signed-off-by: Pankaj Sharma <pankj.sharma@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> ---
> 
> changes in v2:
> - common m_can_ prefix for is_protocol_err function
> - handling stats even if the allocation of the skb fails
> - resolving build errors on net-next branch

No objections from my side.
