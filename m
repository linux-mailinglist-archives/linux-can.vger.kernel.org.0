Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0449848E8D4
	for <lists+linux-can@lfdr.de>; Fri, 14 Jan 2022 12:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiANLF4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 Jan 2022 06:05:56 -0500
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:26053
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232457AbiANLFz (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 14 Jan 2022 06:05:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zo1+PyB7bvW+Xdz0NOaJ8RgvXygrtV6WRp9CRj3KY1Hloa0ZvTLDjArywUiV55641FbkyDZpHWAu/conWjDflQI3btOhGqt3rqv3fwmf7hDqURaWzCNP/LxQT7iQFgZNZEy7yX5txlSNeB/S0+U7d3VvX7n53hJmkxpMZDEfJlNifBj2VMEBqmPID8xuy7P8xJ6R4dxQ5HgBcMwImDMal4JSS+NGzx6E0kr1PoKK6lsUOj+vfrxgCJXqCEBc6MirQ9fUsLRjg2SDXWMibv7xOk0BqbUdbfLIZ4sbqGAOL3mJOfh8gy23d4vaRL7JgSbW1Z7ffAUakwGFRsjKAlQXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsBHKKpz+k+XmWTlHkUoZKBBn4fv5ePeKtohbtQu9s0=;
 b=hm7WtBjnF3AV7eUxmg15j11nogrMfCLBNI1wR7KeeLlQ8ZXRjUUYdhisuBb4v4gXoyMZAy9Rkj3WBJmzq9GvhZO8mWB/YG2DlV8Hz79EGBAKB3LBJJKNkFI7Ml6zSMGODm3ky+QIsIc4LROiimefSIpQP03CZx/hMTYiBEiAGhYWoOkyLmYQP9ZpkT2aCabmLy4Sdn1LajK3Qhw6M0w5tK+i93wp4mNrkV8sPiXNVZrFYObGbrS7Pdiur0KbtLLS81ry7yOE/dFSHKeM+EeNlSMpR5zVbR7795cUhVvCcd3q0WQTXjyUyLrOxEUTC9mcdW2aS61Dj2V5NtvBVU7fOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dpsolutions.se; dmarc=pass action=none
 header.from=dpsolutions.se; dkim=pass header.d=dpsolutions.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dpnorge.onmicrosoft.com; s=selector2-dpnorge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsBHKKpz+k+XmWTlHkUoZKBBn4fv5ePeKtohbtQu9s0=;
 b=nUGAU3E/ag+DGCE/RxUa4mLbLsfkj1UxWrToCpNScK8l4xEEI5XcW8jNEuJ7LYjPMtVys4QpQUJVsO99QQQu9jkNWsc5PHDqnFBsUvYICoUhHs5zFI7C8iTwOLAKtAQ8ajsTTqVVWMQ4AczjO1CJjA+AJFVr9RijBx/axY+q9kY=
Received: from HE1PR04MB3100.eurprd04.prod.outlook.com (2603:10a6:7:21::21) by
 HE1PR0402MB3451.eurprd04.prod.outlook.com (2603:10a6:7:88::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Fri, 14 Jan 2022 11:05:52 +0000
Received: from HE1PR04MB3100.eurprd04.prod.outlook.com
 ([fe80::4949:5038:5888:d0ff]) by HE1PR04MB3100.eurprd04.prod.outlook.com
 ([fe80::4949:5038:5888:d0ff%4]) with mapi id 15.20.4867.012; Fri, 14 Jan 2022
 11:05:51 +0000
From:   Markus Mirevik <markus.mirevik@dpsolutions.se>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: MCP251xFD runs interrupt handler twice per message.
Thread-Topic: MCP251xFD runs interrupt handler twice per message.
Thread-Index: AdgJLvj3LYiHrdzWT92Iflx1OZxh8Q==
Date:   Fri, 14 Jan 2022 11:05:51 +0000
Message-ID: <HE1PR04MB310066D557C9D77FE357D90AE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dpsolutions.se;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78656d19-67d0-4621-f968-08d9d74dd3fa
x-ms-traffictypediagnostic: HE1PR0402MB3451:EE_
x-microsoft-antispam-prvs: <HE1PR0402MB3451219A6BD1A28F31310062E6549@HE1PR0402MB3451.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HYcaE+3Fry7t3eukwnrjXd/evrhlQTu/59/RbC4DxsuxlqzpFoJQGFJghBKzbx2xYrPYs2lJ5fzEHHmLrxDQ65C37PUpPAicp40B6WXxraku1OePO+T6fWvjDJZnXXdbCPYss3JZbbHrLwqLRkvHSqwF13T+RcLSMPJEv5lqwhu9OYXDoIKbsC6xe2SWZn2ItcsVMcjkhKZLRicojWPotoDM6A89HgxBj3BbEXW0V9nmVdp6bfVi6jZ/l7HZoD6GZnYx3WYiDQsG+CoC1R23THr3vV+ayBnin+/3w70DEfkFlipkJWcW4C0YNhvX827ObbRBjRXvSgLc6BTXc/Ho+9bZSfZLo4Emk3eDaMzx6lbiCYJhUR67H41KguIVwhyuUBTvqLD03N0IqY0QIpETk+E7DsrI6ztW7+DaFjhYUQMZH7Rlama6qzQrHoWYUCvZyVjTn1Bfbwa0v7bS4q2yKR/7A5FUVKiGdU8XLG+qYvTO7lIaaMQ4jKbVeZUoQpS+GJAte/KiNolntxfgx76hLoU9CQOmcFGGj1jk7irHwFqXJzfpm34TN/1Az1PecT36ma2uMpDR/3k2FCp1SHeCs8yFULFwW1s9VvEgQo71OOK4ryskWlwDZOYyU28xGS0IIFLgB/AnFmW74it5P7xLxgYccpMuoPt5t316rGRyK+usxLdyCwPS0w+R3r4d2AU/sg2VY6r+aPQyn80UXNa8uKt4x6BjhZNx8m6u5jXpKjgKRvf9f3sijShcFxakESVD013K6PyKQ+wPEPbbuS+IxpnhA0Cgqe2f7V1RbUGNeJw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3100.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(376002)(346002)(396003)(366004)(86362001)(44832011)(38070700005)(2906002)(66946007)(122000001)(9686003)(6916009)(55016003)(76116006)(26005)(66476007)(52536014)(508600001)(38100700002)(33656002)(5660300002)(8936002)(966005)(66446008)(66556008)(71200400001)(8676002)(316002)(4001150100001)(64756008)(83380400001)(6506007)(186003)(7696005)(15650500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E1hg7Sq3XmsiIYdO+fp+IKQRcoSZii7GA2tBK6rMaK9zZ8HtRuZdeGxA4ccw?=
 =?us-ascii?Q?Z81f9ATAwwII0li9nmzjgqykhuol2lffq06+jGHgTi7W1tWHMlwyoJoSfZRh?=
 =?us-ascii?Q?j/rQuk6efGXsM0wGfjFCz751iXoNxwtJJRByAwB7g/wZLQk9nrO+8tgllZV0?=
 =?us-ascii?Q?GOKb3FWhaHfuaNfb1Xjwt2QRPARqIT5phQFaLxW48DaX6HNVeNLeJL3srtjL?=
 =?us-ascii?Q?Of1vM+yIM7PTd9ejbw4Rw1Mjv7ibkyg85ElD67hn1IP14TIisDg6gHEhXvRm?=
 =?us-ascii?Q?xsb16MrpobE7D9+RRNbwmyBMR3IkGxUtc2rXR5TIHrOP9wZyrEA9bSjPhVvd?=
 =?us-ascii?Q?NRPunZLbyjphq/2/wnFhiae7YfFPecGPbX36wcFgwA626soGdrxW0sPdDHDL?=
 =?us-ascii?Q?kUaR8ibqh7vEFYwq7CiDgd9Fi8/NiZZV5VCQoY1WjZj/tvTDO3CwgPIsfarr?=
 =?us-ascii?Q?P5tBciaCh/xR3pR/GKCWRu3ksUS9nhU4hcbSHjiogge1u00YLpEDpgLbwylX?=
 =?us-ascii?Q?RVUopu/MDt8Nn9Zyejpi9ZHBYpy7GuyB/QeNBDCO+RGozdLzkZwFKn358gzI?=
 =?us-ascii?Q?E2V+vjM0Xs9YGYKdfTeBZI6HIDTRUwJ0z740ZICk81N64bRICW+U82A+uThC?=
 =?us-ascii?Q?q87KKF7lrg1mMouDUurpd99DgPJTpUPkEkK5IDshuEDwyELyeHHPghwWNOqV?=
 =?us-ascii?Q?LjyJQQoziFqe5w+So7Bj+1dV6PNKI/ZzjZBgTgwPNZ1tdH2F7EWJG0LsZRsb?=
 =?us-ascii?Q?S4kYL3j475PIS8MaesSjlEXHiSO07/Y+A3w7CQ1j5EHd/B4BgwK0FAuLk/Qa?=
 =?us-ascii?Q?I98LwIo4qVoWSBoQK1TgbSkiCW/rw77rL8UX6dMN31qp0kMad9qMFnnv906C?=
 =?us-ascii?Q?GoHg6DiJGsDsKpBtxDST7bV4ubWURkMNrsM1YVF1GGLU4LHHSOHQz30gWk0s?=
 =?us-ascii?Q?vJhk0/AicC8mhevlr15y3Zzm8cMduYzr9mtgEj21EV/l0rzN32ZlT5ftULcx?=
 =?us-ascii?Q?ktD1ojglJjdqqA3xS7QJ0UzJkp9+vetmeAMwOKrzlz7RM+2C3S6XUc3cwXTl?=
 =?us-ascii?Q?TEMqlPizWqvSvyKZ7U5eiG8v7t8yDx2uwdFfXGeTP2LuSAUkSCnti3atArhA?=
 =?us-ascii?Q?fFF8mUzuV/xKOgnWawDK3Uv4Hpzo3sldwNNo4VWro3ziRV1K1NlhflxGof8Z?=
 =?us-ascii?Q?WXK1RUzdJUqg5dg4gH3JxJEPn8Gz24ol4G1PMFehDSo5ReLmJ5ukhmY5SVGi?=
 =?us-ascii?Q?eUKzVbyMP0Gr1PbsB0WlONW4TulDPfBAeC1+6s4XoRbyEOCgzAcqPOr5xnlz?=
 =?us-ascii?Q?AQXf/nfkAjneKSRuULfVb7mEDRXBLkrcVlfQ0129KJ2akmWqjcaFdrycnHkI?=
 =?us-ascii?Q?qu1OnbLLMOIQR84s1B6AlvUQk2wWF5f6VPR/y4JVpw8B1pFU9sW7r1NlzWWR?=
 =?us-ascii?Q?O/RtHC81D/XVfqD1mrq63BuJ4UYUwrbz38LLnZnxxGFmWYNMqj3xMeWHZqOv?=
 =?us-ascii?Q?UGtACGNTaIKccZ2OjBtQ1i/bPTkk2JSTs80c1qU5lr/KRAkxGqq0szHxk42d?=
 =?us-ascii?Q?cdDn4kCMfDU8TIdvqqS1fgpGzcG5G8R1ySYRV1gsABWW8wiCb6T3MWSB5sEc?=
 =?us-ascii?Q?V61ToE6SlWstxItfozyPyWYVG2/FyFFckZH0dMBWOzU7sPcPcGTstIje6JeF?=
 =?us-ascii?Q?B/0hLQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dpsolutions.se
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3100.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78656d19-67d0-4621-f968-08d9d74dd3fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 11:05:51.6342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3a2c5ea5-12ca-4b9d-9883-156f72a0a4ae
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kj0Z2fuYOBfu+Qf/9sFX0GDVwuHJMsEYgbNsX0IpECa0jfVKrbZktBQmwnhx0Ck4/Ka/IJqD0/+g9OV/93opFki34iiR3XBcZBW9cw9L4J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3451
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello

I have performance problems with mcp2518fd. I have custom board based of be=
agleboard black. (Sitara am335x) using two mcp2518fd. The can communication=
 uses a lot of CPU.  irq/64-spi1.1 uses around  ~20% at 1000 can messages/s=
.

I have several questions but I'll start with the most confusing.  I have fo=
und that every can messages fires two interrupts on my board. I have tested=
 this in several ways. If I send one normal can message the counter in /pro=
c/interrupts is increased twice. I have also put some printouts in mcp251xf=
d-core.c that confirms that mcp251xfd_irq() is run twice and the second tim=
e intf_pending is 0.

And for testing purposes I changed the interrupt config to trigger on falli=
ng edge instead of level and with this configured there is only one interru=
pt fired. But I guess this will risk locking the interrupt line low if an e=
dge isn't detected.=20

I have tried both with rx-int active and inactive. My scope shows really ni=
ce signals and that  rx-int and int is deactivated simultaneous on incoming=
 frames.=20

I'm testing by sending messages from my computer through a can dongle.=20

The board is currently running Linux 5.10.79-yocto-tiny #1 SMP Tue Nov 16 0=
3:57:43 UTC 2021 armv7l armv7l armv7l GNU/Linux
I've also tested updating the driver to the one from https://github.com/mar=
ckleinebudde/linux.git from 2021-12-29 with the same result (IRQ handler ru=
n twice).=20

I am profoundly confused by this issue and I can not figure out why it's ha=
ppening. My understanding is that since the IRQ handler is loaded with IRQF=
_ONESHOT the irq line should be masked until mcp251xfd_irq() returns. Since=
 mcp251xfd_irq() checks that !rx_pending before exiting the int signal must=
 be high. And the interrupt should not fire again...=20

Result from init:
[    4.003029] mcp251xfd spi1.0 can0: MCP2518FD rev0.0 (+RX_INT -MAB_NO_WAR=
N +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:0.00=
MHz) successfully initialized.
[    4.028220] mcp251xfd spi1.1 can1: MCP2518FD rev0.0 (-RX_INT -MAB_NO_WAR=
N +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:0.00=
MHz) successfully initialized.

This is the current dtsi part for the canFD chips. (With rx-pin removed on =
one of the devices and trigger on edge on the other for debugging purposes)=
.=20

#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/interrupt-controller/irq.h>

&am33xx_pinmux{
        pinctrl_spi1_pins: pinctrl_spi1_pins {
                pinctrl-single,pins =3D <
                        AM33XX_IOPAD(0x990, PIN_INPUT | MUX_MODE3) /* (A13)=
 mcasp0_aclkx.spi1_sclk */
                        AM33XX_IOPAD(0x994, PIN_INPUT | MUX_MODE3) /* (B13)=
 mcasp0_fsx.spi1_d0 */
                        AM33XX_IOPAD(0x998, PIN_INPUT | MUX_MODE3) /* (D12)=
 mcasp0_axr0.spi1_d1 */
                        AM33XX_IOPAD(0x96c, PIN_OUTPUT_PULLUP | MUX_MODE5) =
/* (E17) uart0_rtsn.spi1_cs0         CleANopen       LEFT*/
                        AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLUP | MUX_MODE4) =
/* (A15) xdma_event_intr0.spi1_cs1   SAWM CAN        RIGHT*/
                >;
        };

        can0_int_pins: can0_int_pins {
                pinctrl-single,pins =3D <
                /*CleANopen*/
                AM33XX_IOPAD(0x89c, PIN_INPUT_PULLUP | MUX_MODE7) /* (T6) g=
pmc_be0n_cle.gpio2[5]        nINT            */
                AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE7) /* (E18) =
uart0_ctsn.gpio1[8]          nINT1           */
                >;
        };

        can1_int_pins: can1_int_pins {
                pinctrl-single,pins =3D <
                /*SAWM CAN*/
                AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE7) /* (U10) =
gpmc_ad8.gpio0[22]           nINT            */
                AM33XX_IOPAD(0x8c8, PIN_INPUT_PULLUP | MUX_MODE7) /* (U3) l=
cd_data10.gpio2[16]  nINT1           */
                AM33XX_IOPAD(0x8cc, PIN_INPUT_PULLUP | MUX_MODE7) /* (U4) l=
cd_data11.gpio2[17]  nINT0 NOT USED  */
                >;
        };
};



/{
        /* external 40M oscillator of mcp2518fd on SPI1.0 */
        mcp2518fd_can0_osc: mcp2518fd_can0_osc {
                compatible =3D "fixed-clock";
                #clock-cells =3D <0>;
                clock-frequency =3D <40000000>;
        };
};


/{
        /* external 40M oscillator of mcp2518fd on SPI1.1 */
        mcp2518fd_can1_osc: mcp2518fd_can1_osc {
                compatible =3D "fixed-clock";
                #clock-cells =3D <0>;
                clock-frequency =3D <40000000>;
        };
};

/* the spi config of the can-controller itself binding everything together =
*/
&spi1{
    #address-cells =3D <1>;
    #size-cells =3D <0>;

    status =3D "okay";
    pinctrl-names =3D "default";
    pinctrl-0 =3D <&pinctrl_spi1_pins>;

    /*CleANopen*/
    can@0 {
        compatible =3D "microchip,mcp2518fd";
        reg =3D <0>;
        clocks =3D <&mcp2518fd_can0_osc>;
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&can0_int_pins>;
        spi-max-frequency =3D <20000000>;
        interrupts-extended =3D <&gpio2 5 IRQ_TYPE_EDGE_FALLING>;
        microchip,rx-int-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;
    };

    can@1 {
        compatible =3D "microchip,mcp2518fd";
        reg =3D <1>;
        clocks =3D <&mcp2518fd_can1_osc>;
        pinctrl-names =3D "default";
        pinctrl-0 =3D <&can1_int_pins>;
        spi-max-frequency =3D <20000000>;
        interrupts-extended =3D <&gpio0 22 IRQ_TYPE_LEVEL_LOW>;
//        microchip,rx-int-gpios =3D <&gpio2 16 GPIO_ACTIVE_LOW>;
    };
};

=20
BR
Markus Mirevik

