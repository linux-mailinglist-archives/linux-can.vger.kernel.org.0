Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D102785FC
	for <lists+linux-can@lfdr.de>; Fri, 25 Sep 2020 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgIYLfS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Sep 2020 07:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYLfS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Sep 2020 07:35:18 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89128C0613CE;
        Fri, 25 Sep 2020 04:35:18 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6211622F2E;
        Fri, 25 Sep 2020 13:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601033716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1TDOPkAjQyv3W89Ok1hTNiiexbVaPDGOpKU5ZXVXX4A=;
        b=HDoBrEoB+Oozg7X8kGt13kNrZ666ElU296shSR8VnXy5qI7KdNcqBQEN9oGLt8DDFk8FaB
        m7UuTzAMVUcT5ElMa7Xm3kjfj3NDuY6tOa767hvW2qanLR4T5+UnAEQ933f5to24dDRNZk
        PB13PkUswqAY5ZMUoCpYn2WJxT+6crg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Sep 2020 13:35:14 +0200
From:   Michael Walle <michael@walle.cc>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Leo Li <leoyang.li@nxp.com>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 1/2] arm64: dts: ls1028a: add missing CAN nodes
In-Reply-To: <790ce102-7542-b65e-0945-a04faf6e4b89@pengutronix.de>
References: <20200923095711.11355-1-michael@walle.cc>
 <20200923095711.11355-2-michael@walle.cc>
 <VE1PR04MB6687AC23E100D138FEDB012A8F390@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <e9347e4c2e070ee9e8aa7a8007d89f02@walle.cc>
 <VE1PR04MB6687CF32DBCC76B4DFBA070A8F390@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <cd04c75c5d92371eca86d269cb17bcb3@walle.cc>
 <790ce102-7542-b65e-0945-a04faf6e4b89@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <96727fac8db86b73f8c1bcba0cdc2d4a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 2020-09-25 11:34, schrieb Marc Kleine-Budde:
> On 9/25/20 11:31 AM, Michael Walle wrote:
>> Marc, I'd convert this to yaml format,
> 
> Oleksij (CC'ed) is working already on this.

Cool.

Oleksij, if there will be individual compatible strings, could you
already add the one for the LS1028A? i.e.
  "fsl,ls1028ar1-flexcan" followed by "fsl,lx2160ar1-flexcan"

-michael
