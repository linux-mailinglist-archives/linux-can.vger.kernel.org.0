Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAFF27567F
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 12:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIWKis (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 06:38:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36558 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKir (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 06:38:47 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NAa2F9193395;
        Wed, 23 Sep 2020 10:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8UL56PQ1GdoCBFBenUkc9or7Ou5lFzOjhNS7K77EuAg=;
 b=cij1WoGCgi1/phtxj6k6IMfD2ArDHn67kyRMZFdsdm/W/oqWAC2M4hTE6u7WLPHcpla3
 j7p3MiAcoMGyK1rgpF7lXW9azXZ433BmxQhYqJihFQyRIwN2DS/QR+CVnHOdaSg/cFJU
 D7ocV2se/8+936Yc0CU1QAGLB+AnRx5x4me9S59VLkqH/zDgq4px2YRqwjL3gxukn1Lg
 nF9aXcH2Zc5VICSeBINl5RgVz+hWWMfElrr5DcKkaZA8zltfafmDVfGE8VGVFw2NFozg
 uWXqAuUHSLsDT0KtkoKKkB12V6wsMbpGdrHBVntMB5/hNmGVJg+kDXB8/IfcZLZNO9QE Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33qcptxkcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 10:38:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NAUShl138395;
        Wed, 23 Sep 2020 10:38:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 33nujpem8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Sep 2020 10:38:37 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08NAcbnE030124;
        Wed, 23 Sep 2020 10:38:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Sep 2020 03:38:36 -0700
Date:   Wed, 23 Sep 2020 13:38:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [bug report] can: mcp25xxfd: add driver for Microchip MCP25xxFD
 SPI CAN
Message-ID: <20200923103831.GI18329@kadam>
References: <20200923095447.GA1464378@mwanda>
 <6b4ce720-7208-24b5-1057-613eedc0fd6d@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4ce720-7208-24b5-1057-613eedc0fd6d@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230083
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, Sep 23, 2020 at 12:26:42PM +0200, Marc Kleine-Budde wrote:
> On 9/23/20 11:54 AM, Dan Carpenter wrote:
> > Hello Marc Kleine-Budde,
> > 
> > The patch 55e5b97f003e: "can: mcp25xxfd: add driver for Microchip
> > MCP25xxFD SPI CAN" from Sep 18, 2020, leads to the following static
> > checker Smatch warning:
> > 
> > drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2271 mcp25xxfd_tx_obj_from_skb() warn: user controlled 'len' cast to postive rl = '(-249)-(-1),1-67'
> > drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2272 mcp25xxfd_tx_obj_from_skb() error: 'memcpy()' 'hw_tx_obj->data' too small (64 vs 255)
> > drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2272 mcp25xxfd_tx_obj_from_skb() error: 'memcpy()' 'cfd->data' too small (64 vs 255)
> > drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c:2272 mcp25xxfd_tx_obj_from_skb() error: 'cfd->len' from user is not capped properly
> > 
> > (Only one of these checks is published and it's disabled unless you
> > run with the --spammy flag).
> 
> >From my point of view they look like false positive, let's see:
> 

Yeah.  You're right.  Sorry about that.

regards,
dan carpenter

